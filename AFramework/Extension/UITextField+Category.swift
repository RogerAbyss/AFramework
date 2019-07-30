//
//  UITextField+Category.swift
//  AFramework
//
//  Created by abyss on 2019/5/2.
//

import Foundation

public extension UITextField {
    /**
     * 检验是否有值
     * 至少是 x 位, 不指定 则大于0位即可
     */
    func validEmpty(_ msg: String = "", _ x: Int = 0) -> Bool {
        let flag = self.text!.validEmpty(x)
        
        if !flag {
            if msg.count > 0 {
//                Hud.show(type: .warning, text: msg)
            } else {
//                Hud.showMiss()
            }
        }
        
        return flag
    }
}
