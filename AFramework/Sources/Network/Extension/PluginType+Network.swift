//
//  PluginType+Network.swift
//  AFramework
//
//  Created by abyss on 2019/4/29.
//

import Moya

public extension PluginType {
    var logEnable: Bool { return M.shared.config.network.log_enable }
    var cacheEnable: Bool { return M.shared.config.network.cache_enable }
}
