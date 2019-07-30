//
//  AccountUtil.swift
//  AFramework
//
//  Created by abyss on 2019/7/3.
//

import SwiftyUserDefaults

public extension DefaultsKeys {
    static let AccountList = DefaultsKey<Array<Dictionary<String,String>>>("__AccountList", defaultValue: [])
}

public class AccountUtil {
    static public func save(mobile: String, password: String) {
        var list = Defaults[.AccountList]
        
        /** 不添加重复账号, 但刷新时间 */
        list = list.filter { $0["mobile"] != mobile }
        
        list.append(
            [
                "mobile":mobile,
                "password":password,
                "time":"\(Int(Date().timeIntervalSince1970))"
            ]
        )

        Defaults[.AccountList] = list
    }
    
    static public func remove(mobile: String) {
        var list = Defaults[.AccountList]
        
        list = list.filter { $0["mobile"] != mobile }
        
        Defaults[.AccountList] = list
    }
    
    static public func list() -> [Dictionary<String,String>] {
        let list = Defaults[.AccountList]
        
        return list
    }
    
    static public func removeAll() {
        Defaults[.AccountList] = []
    }
}
