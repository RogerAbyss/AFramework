//
//  FrameworkReportLog.swift
//  AFramework
//
//  Created by abyss on 2019/5/1.
//

import UIKit

class FrameworkReportLog: NSObject {
    
    /**
     🌴🌱🎮⛱ 🏖 🏝 🏜 🌋
     💊💉⚔️ ⚙️🗑
     ⏰🛡🎁🎈📔📄  🛸 🚁 🛶 ⛵️ 🚤 🛥 🛳
     ❤️ 🧡 💛 💚 💙 💜 🖤 💔
     ⚪️ ⚫️ 🔴 🔵
     🔈 🔇 🔕 🍏 🍎 🍭 🍫 🍿
     🥎🧲 🧹⭐️ ✨ ⚡️💥 🔥 ☃️💧
     */
    static func report(_ detail: Bool = false) {
        
        FrameworkReportLog.logLogo()
        if detail {
            FrameworkReportLog.logEmoji()
        }
    }
    
    static func logLogo() {
        print("""
        -------------------------------
        🌈 AFramework Loading...

        by Abyss(roger_ren@qq.com)
        -------------------------------
        """)
    }
    
    static func logEmoji() {
        log.verbose("""
        ----------------------------
                🌈 emoji
        ----------------------------
        🌈 AFramework
        🔥 Error

        🛠 Config
        🧪 DebuggerService
        📶 NetMonitorService
        🌐 Localize
        
        🚀 Network Core
        ✈️ Network Request
        📦 Network Response
        📁 Network Cache
        🧩 Network Addition
        
        🍀 Kingfisher
        ❄️ Cache
        🌟 Refresh
        ☀️ Pay
        
        💰 Analsys - money
        🔔 Notification
        🔒 Encrypt
        👮🏻‍♀️ Reporter
        🍺 Defaults
        🛰 Location
        
        🍬 Touch
        ☠️ Skeleton

        🖥 HUD

        Platform: ⌚️ 📱 💻 🖥
        ----------------------------
        """)
    }
}
