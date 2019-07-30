//
//  JsonUtil.swift
//  AFramework
//
//  Created by abyss on 2019/4/30.
//

import SwiftyJSON

public class JsonUtil {
    static public func loadJson(_ fileName: String) -> JSON? {
        do {
            if let data = FileUtil.loadFileData(fileName, "json") {
                let json = try JSON(data: data)
                
                return json
            }
        } catch {}
        
        return nil
    }
}

