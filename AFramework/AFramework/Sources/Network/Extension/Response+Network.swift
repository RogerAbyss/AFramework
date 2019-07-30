//
//  Response+Network.swift
//  AFramework
//
//  Created by abyss on 2019/4/29.
//

import Moya

public extension Moya.Response {
    var success: Bool {
        return (httpd || cached || sampled)
    }
    
    var httpd: Bool {
        return self.statusCode == 200
    }
    
    var cached: Bool {
        return self.statusCode == 209
    }
    
    var sampled: Bool {
        return self.statusCode == 208
    }
}
