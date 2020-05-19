//
//  NotificationProtocol.swift
//  Strawberry
//
//  Created by abyss on 2019/7/24.
//

import Foundation

public extension Notification.Name {
    static let 登录 = Notification.Name("__notificationNeedLogin")
    static let 登出 = Notification.Name("__notificationNeedLogout")
    

    static let 用户信息更新 = Notification.Name("__notificationUserInfoUpdate")
    static let 分类更新 = Notification.Name("__notificationCategoryUpdate")
    static let 首页更新 = Notification.Name("__notificationHomeUpdate")
    static let 首页倒计时更新 = Notification.Name("__notificationHomeTimeUpdate")
    
    
    static let 支付成功 = Notification.Name("__notificatioPaySuccess")
    static let 支付失败 = Notification.Name("__notificatioPayFail")
    static let 发现更新 = Notification.Name("__notificationNeedUpdate")
    
    static let 定位更新 = Notification.Name("__notificationLocationUpdate")
}
