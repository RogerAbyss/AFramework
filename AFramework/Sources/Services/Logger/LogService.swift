//
//  LogService.swift
//  AFramework
//
//  Created by abyss on 2019/4/26.
//

import UIKit
import SwiftyBeaver

let log: SwiftyBeaver.Type = SwiftyBeaver.self
public class LogService {
    
    /**
     日志服务, 是需要第一个加载的服务
    */
    static public func setup() {
        let console = ConsoleDestination()
        let file = FileDestination()
        
        console.minLevel = SwiftyBeaver.Level.init(rawValue: M.shared.config.log_level) ?? .verbose
        console.useTerminalColors = true
        console.format = """
        $DHH:mm:ss$d $L $T $N.$F:$l
        $M
        """
        // console.format = "$J"
        
        let log = SwiftyBeaver.self
        
        log.addDestination(console)
        log.addDestination(file)
        
        FrameworkReportLog.report()
        AppInfoLog.report()
        
//        log.debug(CacheService.default.httpCache)
    }
}
