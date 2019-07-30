//
//  Date+Category.swift
//  AFramework
//
//  Created by abyss on 2019/6/2.
//

import Foundation

public extension DateComponents {
    struct DateComponentsDisplayType: OptionSet {
        public let rawValue: Int8
        
        static public let year = DateComponentsDisplayType(rawValue: 1 << 0)
        static public let month = DateComponentsDisplayType(rawValue: 1 << 1)
        static public let day = DateComponentsDisplayType(rawValue: 1 << 2)
        
        public init(rawValue: Int8) {
            self.rawValue = rawValue
        }
    }
    
    func display(type: DateComponentsDisplayType = [.year, .month, .day]) -> String {
        
        var result: String = ""
        if type.contains(.year) {
            if let year = self.year {
                result.append("\(year)年")
            }
        } else if type.contains(.month) {
            if let month = self.month {
                result.append("\(month)月")
            }
        } else if type.contains(.day) {
            if let day = self.day {
                result.append("\(day)日")
            }
        }
        
        return result
    }
}
