//
//  NetworkPluginIndicator.swift
//  AFramework
//
//  Created by 任超 on 2019/4/27.
//

import Moya
//import Result

final public class NetworkPluginIndicator: PluginType {
    
    private static var numberOfRequests: Int = 0 {
        didSet {
            if numberOfRequests > 1 { return }
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = self.numberOfRequests > 0
            }
            
            HudUtil.isVisiable = self.numberOfRequests > 0
        }
    }
    
    public init() {
        log.debug("🚀 Netwrok插件-Indicator 开启")
    }
    
    public func willSend(_ request: RequestType, target: TargetType) {
        guard (target as! NetworkTargetType).backgroundable == false else { return }
        log.debug("🖥 HUD \(target.path)")
        NetworkPluginIndicator.numberOfRequests += 1
    }
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        guard (target as! NetworkTargetType).backgroundable == false else { return }
        NetworkPluginIndicator.numberOfRequests -= 1
    }
}

