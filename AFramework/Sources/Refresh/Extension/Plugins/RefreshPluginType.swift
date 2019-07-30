//
//  RefreshPluginType.swift
//  ProjectName
//
//  Created by abyss on 2019/5/4.
//

import Moya

public protocol RefreshPluginType {
    func willSend(refresher: Refresher, byFooter: Bool)
    func didReceive(refresher: Refresher, byFooter: Bool)
}

public extension RefreshPluginType {
    func willSend(refresher: Refresher, byFooter: Bool) {}
    func didReceive(refresher: Refresher, byFooter: Bool) {}
}
