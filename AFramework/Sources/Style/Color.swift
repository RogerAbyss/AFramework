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

extension UIColor {
    /// rgb(a)十进制
    public convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    /// rgb(a)0xffffff十六进制
    public convenience init(_ hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
    
    /// 参数：16进制字符串，不带前缀
    public convenience init(hexStr: String) {
        let hex = strtoul(hexStr, nil, 16)
        self.init(Int(hex))
    }
    
    /// 用自身颜色生成UIImage
    public var image: UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
