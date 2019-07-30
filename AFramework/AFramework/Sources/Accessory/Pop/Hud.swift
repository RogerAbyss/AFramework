//
//  Hud.swift
//  VirtualCoins
//
//  Created by 任超 on 2018/4/26.
//  Copyright © 2018年 Abyss. All rights reserved.
//

import SVProgressHUD
import Foundation
import PopupDialog

/**
 * first of all, you need add asserts to project
 */
public class Hud: NSObject {
    public enum HudType {
        case success
        case info
        case error
        case warning
    }

    public static func setup() {
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setMinimumSize(CGSize(width: 200, height: 100))
        SVProgressHUD.setMaximumDismissTimeInterval(2)
        SVProgressHUD.setMinimumDismissTimeInterval(1)
    }
    
    /**
    * show message
    */
    public class func show(type: HudType, text: String) {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                switch type {
                case .success:
                    SVProgressHUD.showSuccess(withStatus: text)
                case .info:
                    SVProgressHUD.showInfo(withStatus: text)
                case .error:
                    SVProgressHUD.showError(withStatus: text)
                case .warning:
                    SVProgressHUD.showInfo(withStatus: text)
                }
            }
        }
    }
    
    public class func show() {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                SVProgressHUD.show()
            }
        }
    }

    public class func pop() {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                SVProgressHUD.popActivity()
            }
        }
    }
    
    public class func hide() {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
        }
    }
}

