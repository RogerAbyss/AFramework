//
//  Dictionary+Category.swift
//  AFramework
//
//  Created by abyss on 2019/5/2.
//

import Foundation

func += <KeyType, ValueType> ( left: inout Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}

public extension Dictionary {
    mutating func add(_ dictionary: Dictionary) {
        self += dictionary
        
        #if DEBUG
//        log.info("🍬 参数:" + self.description)
        #endif
    }
}
