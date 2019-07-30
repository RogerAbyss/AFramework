//
//  NetworkTargetType.swift
//  ProjectName
//
//  Created by abyss on 2019/4/28.
//

import Moya

public protocol NetworkTargetType: TargetType {
    var baseURL: URL { get }
    var headers: [String: String]? { get }
    var validate: Bool { get }
    var codeKey: String { get }
    var msgKey: String { get }
    var dataKey: String { get }
    
    var mockName: String { get }
    
    var backgroundable: Bool { get }
    var cacheable: Bool { get }
    var retryable: Bool { get }
}

/**
 config it !?
 */
public extension NetworkTargetType {
    var validate: Bool { return false }
    var baseURL: URL { return URL(string: PlistUtil.getStringValue("APP_HOST"))! }
    var headers: [String: String]? { return [:] }
    var codeKey: String { return "errorCode" }
    var dataKey: String { return "data" }
    var msgKey: String { return "msg" }
    
    var mockName: String { return "base" }
    
    var backgroundable: Bool { return false }
    var cacheable: Bool { return false }
    var retryable: Bool { return true }
}
