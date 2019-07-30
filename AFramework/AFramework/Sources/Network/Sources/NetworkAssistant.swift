//
//  NetworkAssistant.swift
//  AFramework
//
//  Created by abyss on 2019/4/30.
//

import Moya

public class NetworkAssistant {
    public var retryTimes: Int = 0
    public var response: Moya.Response?
    public var target: NetworkTargetType?
    
    public init() {
    }
}
