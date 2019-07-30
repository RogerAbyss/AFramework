//
//  MockUtil.swift
//  AFramework
//
//  Created by abyss on 2019/4/30.
//

import SwiftyJSON

public enum MockImageType: String {
    case icon = "icon"
    case item = "item"
    case banner = "banner"
    case avatar = "avatar"
    case none = "none"
}

public class MockUtil {
    static public func mockApi(_ mockName: String, _ api: String) -> Data {
        if let json = JsonUtil.loadJson(mockName) {
            
            if let content = json["mock"][api].rawString() {
                return content.data(using: .utf8)!
            }
        }
        
        log.error("🔥 mock数据失败")
        return JSON(["errorCode":"0", "mag":"找不到mock数据"]).rawString()!.data(using: .utf8)!
    }
    
    static public func mockImg(_ type: MockImageType = .avatar) -> String {
        guard type.rawValue != "none" else { return "" }
        
        if let json = JsonUtil.loadJson("imageMock") {
            let list = json["mock"][type.rawValue].arrayValue
            
            return list[Int(arc4random()%UInt32(list.count))].stringValue
        }
        
        log.error("🔥 mock图片失败")
        return ""
    }
}
