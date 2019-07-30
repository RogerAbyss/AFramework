//
//  HudUtil.swift
//  AFramework
//
//  Created by abyss on 2019/4/30.
//

import SVProgressHUD

public class HudUtil {
    public static var isVisiable: Bool = false {
        didSet {
            if isVisiable {
                HudUtil.show()
            } else {
                HudUtil.hide()
            }
        }
    }
    
    public static func show() {
        Hud.show()
    }
    
    public static func hide() {
        Hud.hide()
    }
}
