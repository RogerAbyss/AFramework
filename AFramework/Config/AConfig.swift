//
//  AConfig.swift
//  AFramework
//
//  Created by abyss on 2019/4/26.
//

import UIKit

public struct AConfig: Codable {
    public var log_level: Int
    public var key: KeyConfig
    public var project: ProjectConfig
    public var ssl: SSLConfig
    public var network: NetworkConfig
    public var share: ShareConfig
    public var mode: ModeConfig
    public var style: StyleConfig
    public var test_accounts: [TestAccount]
    public var hosts: [NetworkHost]
    
    static public func load() -> AConfig {
        
        #if DEBUG
            let fileName = "config-test"
        #else
            let fileName = "config"
        #endif
        if let config = YamUtils.loadConfig(fileName) {
            print("🛠 加载配置: \(fileName).yml")
            return config
        } else {
            print("🔥 配置加载失败, 使用默认配置。(请检查\(fileName).yml)")
        }

        return AConfig(
            log_level: 0,
            key: KeyConfig(
                id: "",
                pgy: "",
                push: "",
                analysis: "",
                baidu: "",
                wepay: "",
                scheme: "",
                applink: ""
            ),
            project: ProjectConfig(
                start_time: 0,
                build_time: 0,
                memory: "0m",
                binary: "1m"
            ),
            ssl: SSLConfig(
                ssl_enable: true,
                ssl_trust: "example.com"
            ),
            network: NetworkConfig(
                pre_check: false,
                timeout_interval: 60,
                log_enable: true,
                log_image: true,
                stub_enable: false,
                stub_deley: 0,
                cache_enable: true,
                imagemock_enable: false
            ),
            share: ShareConfig(
                wx: WXPlatform(key: "", secret: "")
            ),
            mode: ModeConfig(fast: false),
            style: StyleConfig(
                color: ColorConfig(
                    tint: "",
                    background: "",
                    defaultColor: "",
                    description: "",
                    light: "",
                    disable: "",
                    line: "",
                    price: "",
                    red: ""
                )
            ),
            test_accounts: [
                TestAccount(name: "测试账号",
                       mobile: "17723547371"
                )
            ],
            hosts: [
                NetworkHost(
                    name: "服务器",
                    host: "https://example"
                )
            ]
        )
    }
    
    func descrition() -> String {
        return ""
    }
}

public struct ModeConfig: Codable {
    public var fast: Bool
}

public struct StyleConfig: Codable {
    public var color: ColorConfig
}

public struct ColorConfig: Codable {
    public var tint: String
    
    public var background: String
    
    public var defaultColor: String
    public var description:String
    public var light: String
    
    public var disable: String
    public var line: String
    
    public var price: String
    public var red: String
}

public struct ProjectConfig: Codable {
    public var start_time: TimeInterval
    public var build_time: TimeInterval
    public var memory: String
    public var binary: String
}


public struct KeyConfig: Codable {
    public var id: String
    public var pgy: String
    public var push: String
    public var analysis: String
    public var baidu: String
    public var wepay: String
    public var scheme: String
    public var applink: String
}

public struct ShareConfig: Codable {
    public var wx: WXPlatform
}

public struct WXPlatform: Codable {
    public var key: String
    public var secret: String
}


public struct NetworkConfig: Codable {
    public var pre_check: Bool
    public var timeout_interval: TimeInterval
    public var log_enable: Bool
    public var log_image: Bool
    public var stub_enable: Bool
    public var stub_deley: TimeInterval
    public var cache_enable: Bool
    public var imagemock_enable: Bool
}

public struct NetworkHost: Codable {
    public var name: String
    public var host: String
}

public struct TestAccount: Codable {
    public var name: String
    public var mobile: String
}

public struct SSLConfig: Codable {
    public var ssl_enable: Bool
    public var ssl_trust: String
}


