//
//  ManagerService.swift
//  ProjectName
//
//  Created by abyss on 2019/4/26.
//

import UIKit
import Yams
import Reachability
import SwiftyJSON
import SwiftyUserDefaults
import Moya
import Alamofire

public typealias M = ManagerService
/**
 TODO: what`s final
 */
final public class ManagerService {
    
    static public let shared = ManagerService()
    public var config: AConfig = AConfig.load()
    public var netStatu: Reachability.Connection = .unavailable
    public var home: UIViewController?
    public var nav: UINavigationController?
    public var plugins: EventNetworkPluginCallback!
    public typealias EventNetworkPluginCallback = (_ plugins: [PluginType]) -> [PluginType]
    
    // 请在最开始调用, 第一次请求后此设置失效
    public var policies: [String: ServerTrustEvaluating] = [:]
    
    private init() {}
}
