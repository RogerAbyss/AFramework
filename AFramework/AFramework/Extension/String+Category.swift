//
//  String+Category.swift
//  AFramework
//
//  Created by abyss on 2019/5/2.
//

import Foundation
import SwiftyJSON
import SwiftyRSA
import CryptoSwift

public extension String {
    
    func decimalString() -> String {
        if let decimal = self.decimal() {
            return decimal.string.currency()
        } else {
            return self
        }
    }
    
    /**
     货币显示
     100000000
     */
    func currency() -> String {
        //        return self.currencyString().replacingOccurrences(of: ",", with: "")
        return self.currencyString()
    }
    
    func rsa() -> String {
        do {
            let publicKey = try PublicKey(pemEncoded: Security.key.rsa_key)
            let clear = try ClearMessage(string: self, using: .utf8)
            let encrypted = try clear.encrypted(with: publicKey, padding: .PKCS1)


            return encrypted.base64String
        } catch _ {
            return ""
        }
    }
}

/**
 加密、解密
 */
public extension String {
    func aes() -> String {
        let result = try! Security.aes().encrypt(self.bytes)
        
        return result.toHexString()
    }
    
    func aes_decrypt() -> String {
        let result = try! Security.aes().decrypt(Array<UInt8>(hex: self))
        
        return String(bytes: result, encoding: .utf8) ?? ""
    }
}

/**
 货币
 */
public extension String {
    /**
     货币显示
     
     防止后台浮点类型没有传字符类型
     */
    func currencyString(_ shouldCutZero: Bool = false) -> String {
        if let decimal = self.decimal() {
            let number = NSDecimalNumber(decimal: decimal)
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = shouldCutZero ? 0 : 2
            
            if let result = formatter.string(from: number) {
                /** 默认有精度符号 */
                return result.replacingOccurrences(of: ",", with: "")
            } else {
                return self
            }
        } else {
            return self
        }
    }
    
    /**
     用于计算浮点数
     */
    func decimal() -> Decimal? {
        if let decimal = Decimal(string: self) {
            return decimal
        } else {
            log.info("🍬 Decimal 解析错误")
            return nil
        }
    }
}

/**
 Net 网络数据对接
 */
public extension JSON {
    func jsonString() -> String {
        return (self.rawString() ?? "")
            .replacingOccurrences(of: "\n ", with: "")
            .replacingOccurrences(of: "\\", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "[ ", with: "[")
            .replacingOccurrences(of: ", ", with: ",")
        
        // 去掉了空格
//        return self.description
//            .replacingOccurrences(of: " ", with: "")
//            .replacingOccurrences(of: "\n", with: "")
//            .replacingOccurrences(of: "\\", with: "")
 
    }
}

public extension String {
    func jsonStringTo() -> JSON {
        if let data = self.data(using: .utf8, allowLossyConversion: false) {
            return JSON(data)
        } else {
            log.error("🔥 解析json字符串失败")
        }
        
        return JSON()
    }
}

/**
 数字判断
 */
public extension String {
    /**
     * 是否是Int
     */
    func isPureInt() -> Bool {
        let scan: Scanner = Scanner(string: self)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
    
    /**
     * 是否是Float, 小数位数place
     */
    func isPureFloat(_ place: Int = 99) -> Bool {
        let scan: Scanner = Scanner(string: self)
        var val:Float = 0
        
        var placeValid: Bool = true
        if self.split(separator: ".").count == 2 {
            placeValid = (self.split(separator: ".")[1].count < place + 1)
        }
        
        return scan.scanFloat(&val) && scan.isAtEnd && placeValid
    }
    
    /**
     * 检验是否有值
     * 至少是 x 位, 不指定 则大于0位即可
     */
    func validEmpty(_ x: Int = 0) -> Bool {
        return self.count > x
    }
}

/**
 功能
 */
public extension String {
    /**
     * 拨打电话
     */
    @discardableResult
    func makePhoneCall() -> Bool {
        guard self.count > 4 else { log.info("🍬 拨打电话url不正确: \(self)"); return false }
        
        if let url = URL(string: "tel://"+"\(self)") {
            UIApplication.shared.open(url, options: [:])
            
            return true
        } else {
            log.error("🔥 拨打电话url不正确: \(self)")
            return false
        }
    }
    
    func paste() {
        UIPasteboard.general.string = self
        Hud.show(type: .success, text: "复制成功")
        log.debug("🍬 \(self)")
    }
    
    func openInSafari() {
        if let url = URL(string: self) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
             log.error("🔥 网页url不正确: \(self)")
        }
    }
}

/**
 range
 */
public extension String {
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from..<to
    }
    
    func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
    /**
     * 查找子字符串的位置
     * backwards: 则返回最后出现的位置
     * 没查找到 返回-1
     */
    func positionOf(sub:String, backwards:Bool = false) -> Int {
        var pos = -1
        if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
    
    /**
     * 使用下标截取字符串 例: "示例字符串"[0..<2] 结果是 "示例"
     */
    subscript (r: Range<Int>) -> String {
        get {
            if (r.lowerBound > count) || (r.upperBound > count) { return "截取超出范围" }
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
}

/**
 动态计算宽高
 */
public extension String {
    
    func getDynamicHeight(font: UIFont, width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: 9999)
        let attributes = [NSAttributedString.Key.font: font]
        
        let result: NSString = self as NSString
        return result.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size.height
    }
    
    func getDynamicWidth(font: UIFont, height: CGFloat) -> CGFloat {
        let size = CGSize(width: 99999, height: height)
        let attributes = [NSAttributedString.Key.font: font]
        
        let result: NSString = self as NSString
        return result.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size.width
    }
}
