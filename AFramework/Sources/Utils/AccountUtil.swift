//
//  AccountUtil.swift
//  AFramework
//
//  Created by abyss on 2019/7/3.
//

import SwiftyUserDefaults
import SwiftyJSON

public extension DefaultsKeys {
    static let AccountListV2 = DefaultsKey<[UserProflie]>("__AccountListV2", defaultValue: [])
}

public class UserProflie: Codable, DefaultsSerializable {
    public var mobile: String
    public var password: String
    public var lastTime: TimeInterval
    public var name: String
    
    public init(mobile: String, password: String, name: String) {
        self.mobile = mobile
        self.password = password
        self.lastTime = Date().timeIntervalSince1970
        self.name = name
    }
}

public class AccountUtil {
    static public func save(mobile: String, password: String, name: String) {
        var list = Defaults[.AccountListV2]
        
        /** 不添加重复账号, 但刷新时间 */
        list = list.filter { $0.mobile != mobile }
        
        list.append(
            UserProflie(mobile: mobile, password: password, name: name)
        )

        Defaults[.AccountListV2] = list
    }
    
    static public func remove(mobile: String) {
        var list = Defaults[.AccountListV2]
        
        list = list.filter { $0.mobile != mobile }
        
        Defaults[.AccountListV2] = list
    }
    
    static public func list() -> [UserProflie] {
        let list = Defaults[.AccountListV2]
        
        return list
    }
    
    static public func removeAll() {
        Defaults[.AccountListV2] = []
    }
}
