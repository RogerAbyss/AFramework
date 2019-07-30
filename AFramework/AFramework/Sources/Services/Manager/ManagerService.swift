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

public typealias M = ManagerService
/**
 TODO: what`s final
 */
final public class ManagerService {
    
    static public let shared = ManagerService()
    public var config: AConfig = AConfig.load()
    public var netStatu: Reachability.Connection = .none
    public var home: UIViewController?
    public var nav: UINavigationController?
    public var plugins: EventNetworkPluginCallback!
    public typealias EventNetworkPluginCallback = (_ plugins: [PluginType]) -> [PluginType]
    
    private init() {}
}
