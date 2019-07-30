//
//  FileUtil.swift
//  AFramework
//
//  Created by abyss on 2019/4/30.
//

import UIKit

public class FileUtil {
    static func loadFile(_ fileName: String,_ type: String) throws -> String? {
        if let path = FileUtil.loadFilePath(fileName, type) {
            let content = try String.init(contentsOfFile: path, encoding: .utf8)
            
            if content == "" {
                return nil
            }
            
            return content
        }
        
        return nil
    }
    
    static func loadFilePath(_ fileName: String,_ type: String) -> String? {
        if let path = Bundle.main.path(forResource: fileName, ofType: type) {
            return path
        }
        
        return nil
    }
    
    static func loadFileData(_ fileName: String,_ type: String) -> Data? {
        do {
            if let content = try FileUtil.loadFile(fileName, type) {
                return content.data(using: .utf8)!
            }
        } catch {}
        
        return nil
    }

    static func getFileSize(filePath: String) -> UInt64 {
        let manager = FileManager.default
        if manager.fileExists(atPath: filePath) {
            do {
                let attr = try manager.attributesOfItem(atPath: filePath)
                let size = attr[FileAttributeKey.size] as! UInt64
                return size
            } catch  {
                log.error("🔥 error :\(error)")
                return 0
            }
        }
        
        return 0
    }
    
    static func getFolderSize(filePath: String) -> CGFloat {
        let folderPath = filePath as NSString
        let manager = FileManager.default
        if manager.fileExists(atPath: filePath) {
            let childFilesEnumerator = manager.enumerator(atPath: filePath)
            var folderSize: UInt64 = 0
            while childFilesEnumerator?.nextObject() != nil {
                if let fileName = childFilesEnumerator?.nextObject() as? String {
                    let fileAbsolutePath = folderPath.strings(byAppendingPaths: [fileName])
                    folderSize += getFileSize(filePath: fileAbsolutePath[0])
                }
            }
            
            /** kb */
            return CGFloat(folderSize) / 1024.0
        }
        
        return 0
    }
    
    static func formatSize(_ size: CGFloat) -> String {
        if size > 1024 {
            return String(format: "%.2fm", size/1024.0)
        } else {
            return String(format: "%.2fkb", size)
        }
    }
}

