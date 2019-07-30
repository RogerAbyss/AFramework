//
//  Moya+Network.swift
//  AFramework
//
//  Created by abyss on 2019/4/28.
//

import Moya
import SwiftyJSON
import RxSwift
import Alamofire

open class Network<Target> where Target: NetworkTargetType {
    
    fileprivate var provider = MoyaProvider<Target>()
    
    public typealias NetworkSuccessClousure = (_ assistant: NetworkAssistant, _ data: JSON) -> Swift.Void
    public typealias NetworkFailClousure = (_ assistant: NetworkAssistant, _ json: JSON) -> Swift.Void
    public typealias NetworkErrorClousure = (_ assistant: NetworkAssistant, _ error: MoyaError) -> Swift.Void
    
    public init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = NetworkEndpoint,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = NetworkRequest,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
         manager: Manager = NetworkManager(),

         plugins: [PluginType] = M.shared.plugins([
        NetworkPluginCache(),
        NetworkPluginIndicator(),
        NetworkPluginLog(),
        NetworkPluginHud()
        ]),
         
         trackInflights: Bool = false) {
        
        let stub_enable = M.shared.config.network.stub_enable
        var stubCustom: MoyaProvider<Target>.StubClosure = stubClosure
        
        if stub_enable {
            stubCustom = MoyaProvider<Target>.immediatelyStub
            
            if M.shared.config.network.stub_deley > 0 {
                stubCustom = MoyaProvider<Target>.delayedStub(M.shared.config.network.stub_deley)
            }
        }
        
        self.provider = MoyaProvider(endpointClosure: endpointClosure,
                                     requestClosure: requestClosure,
                                     stubClosure: stubCustom,
                                     manager: manager,
                                     plugins: plugins,
                                     trackInflights: trackInflights)
    }
    
    
    @discardableResult
    public func request(_ target: Target,
                        _ assistant: NetworkAssistant = NetworkAssistant(),
                        _ failCallback: @escaping NetworkFailClousure = {_,_ in},
                        _ errorCallback: @escaping NetworkErrorClousure = {_,_ in},
                        _ successCallback: @escaping NetworkSuccessClousure = {_,_ in}) -> Cancellable? {

        assistant.target = target
        
        let cancellable = provider.request(target) { [unowned self] result in
            switch result {
            case let .success(response):
                assistant.response = response
                if 200..<400 ~= response.statusCode {
                    self.process(target, assistant, successCallback, failCallback, response)
                } else {
                    errorCallback(assistant, MoyaError.statusCode(response))
                }
                break
            case let .failure(error):
                if (self.retryDone(target, assistant, failCallback, errorCallback, successCallback)) {
                    errorCallback(assistant, error)
                }
                break
            }
        }
        
        return cancellable
    }
    
    func retryDone(_ target: Target,
                   _ assistant: NetworkAssistant = NetworkAssistant(),
                   _ failCallback: @escaping NetworkFailClousure = {_,_ in},
                   _ errorCallback: @escaping NetworkErrorClousure = {_,_ in},
                   _ successCallback: @escaping NetworkSuccessClousure = {_,_ in}) -> Bool {
        
        guard target.retryable == true else { return true }
        
        if assistant.retryTimes < 3 {
            DispatchUtil.delay(2) { self.request(target, assistant, failCallback, errorCallback, successCallback) }
            
            assistant.retryTimes += 1
            log.debug("🚀 [重试] 第\(assistant.retryTimes)次 \(target.baseURL)\(target.path)")
            return true
        }
        
        return false
    }
    
    func process(_ target: Target,
                 _ assistant: NetworkAssistant = NetworkAssistant(),
                 _ successCallback: @escaping NetworkSuccessClousure,
                 _ failCallback: @escaping NetworkFailClousure,
                 _ response: Response) {

        let data = JSON(response.data)
        
        if M.shared.config.network.pre_check == true {
            if data[target.codeKey].intValue > 0 {
                let data = JSON(response.data)
                
                successCallback(assistant, data[target.dataKey])
            } else {
                failCallback(assistant, data)
            }
        } else {
            successCallback(assistant, data)
        }
    }
}


public extension Network {
    class func NetworkManager() -> Manager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        
        var serverTrustPolicyManager: ServerTrustPolicyManager?
        
        if SSLUtil.useSSL {
            let policies: [String: ServerTrustPolicy] = [
                "\(SSLUtil.trustHost)": .pinCertificates(
                    certificates: ServerTrustPolicy.certificates(),
                    validateCertificateChain: true,
                    validateHost: true
                ),
            "insecure.expired-apis.com": .disableEvaluation]
            
            log.debug("🚀 [SSL] 启用, 信任域名:\(SSLUtil.trustHost)")
            serverTrustPolicyManager = ServerTrustPolicyManager(policies: policies)
        }
        
        let manager = Manager.init(configuration: configuration, delegate: SessionDelegate(), serverTrustPolicyManager: serverTrustPolicyManager)
        
        manager.startRequestsImmediately = false
        return manager
    }
    
    class func NetworkEndpoint(for target: Target) -> Endpoint {
        return Endpoint(
            url: URL(target: target).absoluteString,
            sampleResponseClosure: { .networkResponse(208, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
            ).adding(newHTTPHeaderFields: NetworkConfiguration.httpHeaders)
    }
    
    class func NetworkRequest(for endpoint: Endpoint, closure: MoyaProvider<Target>.RequestResultClosure) {
        do {
            var urlRequest = try endpoint.urlRequest()
            urlRequest.timeoutInterval = M.shared.config.network.timeout_interval
            closure(.success(urlRequest))
        } catch MoyaError.requestMapping(let url) {
            closure(.failure(MoyaError.requestMapping(url)))
        } catch MoyaError.parameterEncoding(let error) {
            closure(.failure(MoyaError.parameterEncoding(error)))
        } catch {
            closure(.failure(MoyaError.underlying(error, nil)))
        }
    }
}
