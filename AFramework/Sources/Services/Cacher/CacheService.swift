//
//  CacheService.swift
//  AFramework
//
//  Created by abyss on 2019/4/29.
//

import Cache
import Moya
import Kingfisher

public class CacheService {
    
    public var httpCache: Storage<Data>?
    public var imageCache: ImageCache?
    
    public static let `default` = CacheService()
    
    public init() {
        self.httpCache = setupHttpCache()
        self.imageCache = setupImageCache()
        
//        do {
//            try self.httpCache!.removeAll()
//        } catch {}
        
//        setupImageCache()
//        httpCache = AnyObject()
    }
    
    private func setupHttpCache() -> Storage<Data>? {
        
        /**
         TODO:
         60*60*8 时区问题造成过期时间出错
        */
        let memoryConfig = MemoryConfig(
            expiry: .seconds(10*60 + 60*60*8),
            countLimit: 100,
            totalCostLimit: 0
        )
        
        let diskConfig = DiskConfig(
            name: PlistUtil.bundleIndentifier,
            expiry: .seconds(60*60 + 60*60*8),
            maxSize: 20000,
            directory: try! FileManager.default.url(for: .documentDirectory,
                                                    in: .userDomainMask,
                                                    appropriateFor: nil,
                                                    create: true).appendingPathComponent("httpCache"),
            protectionType: .complete
        )
                
        do {
            let storage = try Storage(
                diskConfig: diskConfig,
                memoryConfig: memoryConfig,
                transformer: TransformerFactory.forData())
            
            print("❄️ [http] 缓存初始化: Documents/httpCache")
            return storage
        } catch {
            print("🔥 [http] 缓存创建失败!")
        }
        
        return nil
    }
    
    private func setupImageCache() -> ImageCache? {
        do {
            let path = try! FileManager.default.url(for: .documentDirectory,
                                                      in: .userDomainMask,
                                                      appropriateFor: nil,
                                                      create: true).appendingPathComponent("imageCache")

            let cache = try ImageCache(name: "abyss", cacheDirectoryURL: path)

            print("❄️ [image] 缓存初始化: Documents/imageCache")
            return cache
        } catch {
            print("🔥 [image] 缓存创建失败!")
        }
        
        return nil
    }
    
    func getSize(_ addition: String = "") -> String {
        
        var path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        
        if addition.count > 0 {
            path.append("/\(addition)")
        }
        
        return FileUtil.formatSize(FileUtil.getFolderSize(filePath: path))
    }
    
    public func cleanMemory() {
        KingfisherManager.shared.cache.clearMemoryCache()
        /** TODO: http */
    }
}
