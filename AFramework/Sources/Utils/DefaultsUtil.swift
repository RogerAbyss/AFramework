//
//  DefaultsUtil.swift
//  ProjectName
//
//  Created by abyss on 2019/5/2.
//

import SwiftyUserDefaults

public extension DefaultsKeys {
    /** 是否第一次登录 */
    static let isFirst = DefaultsKey<Bool>("__isFirst", defaultValue: false)
    
    /** host */
    static let app_host = DefaultsKey<String>("__app_host", defaultValue: "")
    
    /** 基础设置 */
    /** 是否保存账号 */
    static let appAccount = DefaultsKey<Bool>("__appAccount", defaultValue: false)
    /** 是否使用生物认证 */
    static let appBio = DefaultsKey<Bool>("__appBio", defaultValue: false)
    /** uuid */
    static let uuid = DefaultsKey<String>("__uuid", defaultValue: "")
}

public class DefaultsUtil {
    static public func isFirst() -> Bool {
        return Defaults[.isFirst]
    }
    
    static public func host() -> String {
        let host = Defaults[.app_host]
        
        if host.count > 0 {
            return host
        } else {
            return PlistUtil.getStringValue("APP_HOST")
        }
    }
}
