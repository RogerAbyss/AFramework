//
//  NetworkPluginHud.swift
//  Strawberry
//
//  Created by abyss on 2019/6/7.
//

import Moya
import SwiftyJSON
//import Result

final public class NetworkPluginHud: PluginType {
    
    public init() {
        log.debug("🚀 Netwrok插件-Hud 开启")
    }
    
    public func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {        
        switch result {
        case .success(let response):
            if 200..<400 ~= response.statusCode {
                
                let ret = JSON(response.data)
                
                let code = ret[(target as! NetworkTargetType).codeKey].intValue
                let msg = ret[(target as! NetworkTargetType).msgKey].stringValue
                
                guard msg.count > 0 else { return result }
                
                if code == 1 || code == 0 {
                    
                } else if (code > 1 && code <= 500) || (code < -1 && code >= -500) {
                    Hud.show(type: .info, text: msg)
                } else if (code > 500 || code < -500) {
                    Alert.showAlertSimple(message: msg)
                }
            } else {
            }
            
            break
        case .failure(let error):
            if error.errorCode == 404 || error.errorCode == 500 {
                Hud.show(type: .error, text: error.errorDescription ?? "\("AFrameworkNoNetwork".localized()) [\(error.errorCode)]")
            }
            
            break
        }
        
        return result
    }
}


