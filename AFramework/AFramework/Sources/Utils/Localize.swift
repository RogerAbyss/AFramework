//
//  Localize.swift
//  AFramework
//
//  Created by abyss on 2019/5/1.
//

import UIKit
import Localize_Swift

public class LocalizeUtil {
    public enum LocalizeUtilLanguage {
        case zh
        case en
    }
    
    static public func setup() {
        log.debug("🌐 当前使用语言: \(Localize.currentLanguage())")
    }
    
    static public func change(language: LocalizeUtilLanguage) {
        switch language {
        case .zh:
            log.debug("🌐 切换中文")
            Localize.setCurrentLanguage("zh-Hans")
            break;
        case .en:
            log.debug("🌐 切换英文")
            Localize.setCurrentLanguage("en")
            break;
        }
    }
}
