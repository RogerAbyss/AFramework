//
//  NotificationSercice.swift
//  Strawberry
//
//  Created by abyss on 2019/7/24.
//

import Foundation


public class NotificationSercice {
    public static let shared = NotificationSercice()
    
    public func send(_ name: Notification.Name) {
        send(name: name, objct: nil)
    }
    
    public func send(name: Notification.Name, objct: Any?) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: name,
                                            object: objct)
            
            log.debug("🔔 发送通知[\(name.rawValue)]")
        }
    }
}
