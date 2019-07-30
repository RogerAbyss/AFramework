//
//  YamUtils.swift
//  AFramework
//
//  Created by abyss on 2019/4/26.
//

import UIKit
import Yams

public class YamUtils {
    /**
     TODO: 与AConfig 解耦
     */
    static func loadConfig(_ fileName: String) -> AConfig? {
        do {
            if let content = try FileUtil.loadFile(fileName, "yml") {
                let decoder = YAMLDecoder()
                let config = try decoder.decode(AConfig.self, from: content)
                
                return config
            }
        } catch {}
        
        return nil
    }
}
