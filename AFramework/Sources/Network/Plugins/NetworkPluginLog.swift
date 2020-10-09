//
//  NetworkPluginLog.swift
//  AFramework
//
//  Created by 任超 on 2019/4/27.
//

import Moya
import SwiftyJSON
//import Result

final public class NetworkPluginLog: PluginType {
    fileprivate var logHeader: Bool = true
    fileprivate var logSesion: Bool = false
    
    public init() {
        log.debug("🚀 Netwrok插件-Log" + (logEnable ? "开启":"禁用"))
    }
    
    public func willSend(_ request: RequestType, target: TargetType) {
        guard logEnable == true else { return }
        
        var bodySection = ""
        if let body = request.request!.httpBody {
            bodySection = "🧩 body: \(JSON(body).description)"
        }
        
        var headerSection = ""
        if logHeader == true {
            headerSection = "\n🧩 header: \(request.request!.allHTTPHeaderFields!)"
        }
        
        log.debug("""
            
            ✈️ [\(request.request!.httpMethod!)] \(request.request!.url?.absoluteString ?? String())
            \(bodySection)\(headerSection)
            """)
    }
    
    public func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        guard logEnable == true else { return result }
        
        switch result {
        case .success(let response):
            if 200..<400 ~= response.statusCode {
                log.debug("""
                    📦 [\(response.request!.httpMethod!) - \(response.statusCode)] \(response.request!.url?.absoluteString ?? String())
                    \(JSON(response.data))
                    """)
            } else {
                log.error("""
                    🔥 [\(response.request!.httpMethod!)] \(response.request!.url?.absoluteString ?? String())
                    http状态码错误 - \(response.statusCode)
                    \(JSON(response.data))
                    """)
            }
            break
        case .failure(let error):
            log.error("""
                🔥 请求失败:
                \(error)
                """)
            break
        }
        
        return result
    }
}

