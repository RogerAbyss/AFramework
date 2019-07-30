//
//  JSON+Category.swift
//  AFramework
//
//  Created by abyss on 2019/5/2.
//

import SwiftyJSON

public extension JSON {
    /**
     如果是数字类型, 会使用decimal解析
     更安全的取数值方式
     会省略位数哦
     
     额外的判断增加的程序开销
     */
    func numberString(_ min: Int = -1, _ max: Int = -1) -> String {
        //        return self.stringValue
        
        
        let string = self.stringValue
        /**
         整数也会判断为浮点数, 所以额外判断一个小数点
         */
        if string.isPureFloat() && string.contains(".") {
            if let number = self.number {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                
                if (min >= 0)
                {
                    formatter.minimumFractionDigits = min
                }
                
                if (max >= 0)
                {
                    formatter.maximumFractionDigits = max
                }
                
                if let result = formatter.string(from: number) {
                    return result.replacingOccurrences(of: ",", with: "")
                } else {
                    return string
                }
            } else {
                return string
            }
        } else {
            return string
        }
    }
    
    /**
     货币 用于计算
     */
    func decimal() -> Decimal? {
        return self.numberString().decimal()
    }
    
    /**
     货币 用于显示
     100,000,000
     */
    func currencyString() -> String {
        return self.numberString().currency()
    }
}
