//
//  Debugger.swift
//  AFramework
//
//  Created by abyss on 2019/4/22.
//

import UIKit
import Sheeeeeeeeet
import SwiftyUserDefaults
#if DEBUG
import DoraemonKit
#endif

public class DebuggerService {
    static public func setup() {
        #if DEBUG
        DoraemonManager.shareInstance().addPlugin(withTitle: "环境切换",
                                                  icon: "doraemon_default",
                                                  desc: "用于app内部环境切换功能",
                                                  pluginName: "DoraemonEnvPlugin",
                                                  atModule: "业务专区",
                                                  handle:
            { data in
                log.debug("🧪 DoraemonKit 环境工具")
                DoraemonManager.shareInstance().hiddenHomeWindow()
                
                var list = [
                    [
                        "name":"☀️ 当前服务器: \(DefaultsUtil.host())",
                        "host":"\(DefaultsUtil.host())",
                    ],
                    [
                        "name":"☀️ 自定义host",
                    ]
                ]
                
                M.shared.config.hosts.forEach { item in
                    list.append(
                        [
                            "name": "\(item.name): \(item.host)",
                            "host": item.host
                        ]
                    )
                }
                
                Sheet.showSheet(
                    cancelButton: "取消",
                    items: list,
                    vc: M.shared.nav!.viewControllers.last!) { (sheet, item) in
                    if item is OkButton {
                        
                    } else if item is CancelButton {
                        sheet.dismiss()
                    } else {
                        let tag = item.value as! Int
                        
                        /** 不切换 */
                        if tag > 1 {
                            let select_host = list[tag]["host"] ?? ""
                            log.debug("🧪 选择服务器 \(select_host)")
                            Defaults[.app_host] = select_host
                            
                            NotificationSercice.shared.send(.登出)
                        } else {
                            JumperUtil.jumpTo(storyboard: "DebuggerServiceTool",
                                              identifier: "DebuggerServiceHostHelperViewController")
                        }
                    }
                }
        })
        
        DoraemonManager.shareInstance().addPlugin(withTitle: "检查更新",
                                                  icon: "doraemon_default",
                                                  desc: "检查更新测试App",
                                                  pluginName: "DoraemonRichPlugin",
                                                  atModule: "业务专区",
                                                  handle:
            { data in
                log.debug("🧪 DoraemonKit 更新工具")
                DoraemonManager.shareInstance().hiddenHomeWindow()
                
                NotificationSercice.shared.send(.发现更新)
        })
        #endif
    }
    
    static public func hide() {
        #if DEBUG
        DoraemonManager.shareInstance().hiddenHomeWindow()
        #endif
    }
}
