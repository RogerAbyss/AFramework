//
//  NetMonitorService.swift
//  AFramework
//
//  Created by abyss on 2019/4/26.
//

import UIKit
import Reachability
import SwiftyUserDefaults

public class NetMonitorService {
    
    static public var shared = try! Reachability()
    static public func setup() {
        
        NetMonitorService.shared.whenReachable = { reachability in
            
            M.shared.netStatu = reachability.connection
            
            if reachability.connection == .wifi {
                log.debug("📶 网络变化: 使用WIFI")
                Defaults[.nw] = "wifi"
            } else {
                var networkType = "unknown"
                
                // 网络闪退
//                let info = CTTelephonyNetworkInfo()
//
//                if info.subscriberCellularProvider != nil {
//                    if let currentRadioTech = info.currentRadioAccessTechnology {
//                        switch currentRadioTech {
//                        case CTRadioAccessTechnologyGPRS,CTRadioAccessTechnologyEdge,CTRadioAccessTechnologyCDMA1x:
//                            networkType = "2G"
//                        case CTRadioAccessTechnologyeHRPD,CTRadioAccessTechnologyHSDPA,CTRadioAccessTechnologyCDMAEVDORev0,CTRadioAccessTechnologyCDMAEVDORevA,CTRadioAccessTechnologyCDMAEVDORevB,CTRadioAccessTechnologyHSUPA:
//                            networkType = "3G"
//                        case CTRadioAccessTechnologyLTE:
//                            networkType = "4G"
//                        default:
//                            break
//                        }
//                    }
//                }
                
                Defaults[.nw] = networkType
                log.debug("📶 网络变化: 使用流量[\(networkType)]")
            }
        }
        
        NetMonitorService.shared.whenUnreachable = { _ in
            log.debug("📶 网络变化: 没有网络")
        }
        
        do {
            try NetMonitorService.shared.startNotifier()
        } catch {
            log.debug("📶 网络探针开启")
        }
        
        do{
            try NetMonitorService.shared.startNotifier()
        }catch{
            log.error("🔥 网络探针开启失败")
        }
    }
    
    static public func close() {
        NetMonitorService.shared.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: NetMonitorService.shared)
    }
    
    
    /** 处理通知
    @objc func reachabilityChanged(note: Notification) {
        
        /** 增加通知
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityChanged(note:)),
                                               name: .reachabilityChanged,
                                               object: reachability)
        */
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            print("Network not reachable")
        }
    }
    */
}
