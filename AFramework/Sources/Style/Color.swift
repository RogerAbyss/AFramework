//
//  Color.swift
//  AFramework
//
//  Created by abyss on 2019/5/6.
//

import Foundation

public extension UIColor {
    // 金色主题 d9c1a1
    static var app_tintColor: UIColor = UIColor(hexString: M.shared.config.style.color.tint)!
    
    static var app_background: UIColor = UIColor(hexString: M.shared.config.style.color.background)!
    
    static var app_default: UIColor = UIColor(hexString: M.shared.config.style.color.defaultColor)!
    static var app_description: UIColor = UIColor(hexString: M.shared.config.style.color.description)!
    static var app_light: UIColor = UIColor(hexString: M.shared.config.style.color.light)!
    
    static var app_disable: UIColor = UIColor(hexString: M.shared.config.style.color.disable)!
    static var app_line: UIColor = UIColor(hexString: M.shared.config.style.color.line)!
    
    static var app_price: UIColor = UIColor(hexString: M.shared.config.style.color.price)!
    static var app_red: UIColor = UIColor(hexString: M.shared.config.style.color.red)!
}
