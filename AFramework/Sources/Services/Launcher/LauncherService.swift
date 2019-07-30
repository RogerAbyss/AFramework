//
//  LauncherService.swift
//  AFramework
//
//  Created by abyss on 2019/4/26.
//

import UIKit
import IQKeyboardManagerSwift

public class LauncherService {
    static public func setup() {
        #if DEBUG
            LogService.setup()
            DebuggerService.setup()
        #endif
    
        NetMonitorService.setup()
        LocalizeUtil.setup()
        Refresher.setup()
        
        /** 键盘控制 */
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
}
