//
//  LauncherService.swift
//  AFramework
//
//  Created by abyss on 2019/4/26.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftyUserDefaults
import AdSupport

public class LauncherService {
    static public func setup() {
        #if DEBUG
            LogService.setup()
            DebuggerService.setup()
        #endif
    
        NetMonitorService.setup()
        LocalizeUtil.setup()
        Refresher.setup()
        LauncherService.getUUID()
        
        /** 键盘控制 */
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    @discardableResult
    public static func getUUID() -> String {
        if Defaults[.uuid].count < 1 {
            var uuid = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            
            if uuid.count < 1 {
                uuid = UUID().uuidString
            }
            
            Defaults[.uuid] = uuid
        }
        
        print("🌈 uuid: \(Defaults[.uuid])")
        return Defaults[.uuid]
    }
}
