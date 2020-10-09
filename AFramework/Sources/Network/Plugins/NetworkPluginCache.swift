//
//  NetworkPluginCache.swift
//  AFramework
//
//  Created by abyss on 2019/4/29.
//

import Moya
//import Result
import SwiftyJSON

final public class NetworkPluginCache: PluginType {
    
    public init() {
        log.debug("🚀 Netwrok插件-Cache 开启")
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        guard cacheEnable == true else { return }
        
        if case let .success(response) = result {
            if response.statusCode == 200 && JSON(response.data)["errorCode"] == 1  {
                if ((target as! NetworkTargetType).cacheable) {

                    let key = "\(response.request!)"
                    do {
                        try CacheService.default.httpCache!.setObject(response.data, forKey: key)
                    } catch {
                        log.error("🔥 [存缓存] \(key) 失败!")
                    }
                    
                    log.debug("📁 [存缓存] \(key)")
                }
            }
        }
    }
    
    public func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        guard cacheEnable == true else { return result }
        
        if case let .success(response) = result {
            if response.statusCode == 200 {
                if ((target as! NetworkTargetType).cacheable) {
                    let key = "\(response.request!)"
                    
                    log.debug("📁 [取缓存] \(key)")
                    return getCache(result, key, response.request!)
                }
            }
        }
        
        return result
    }
    
    private func getCache(_ result: Result<Response, MoyaError>,_ key: String, _ request: URLRequest)->Result<Response, MoyaError>{
        do {
            let entry = try CacheService.default.httpCache!.entry(forKey: key)
            
            if !entry.expiry.isExpired {
                let response = Response(statusCode: 209,
                                        data: entry.object,
                                        request: request)
                
                return .success(response)
            }
            
            log.debug("📁 [缓存过期] - 过期时间:\(entry.expiry.date.description)")
        } catch {
            log.debug("🔥 [缓存错误] - key:\(key)")
        }
        
        return result
    }
}
