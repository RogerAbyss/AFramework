//
//  Refresher+MJRefresh.swift
//  AFramework
//
//  Created by abyss on 2019/5/6.
//

import MJRefresh
import SwifterSwift

public extension Refresher {
    func addHeader() {
        let header = MJRefreshNormalHeader(refreshingBlock: { [unowned self] in
            log.debug("🌟 Refresher 开始刷新")
            
            self.requestData(byFooter: false)
        })
        
        header?.setTitle("", for: .idle)
        header?.setTitle("", for: .noMoreData)
        header?.setTitle("", for: .pulling)
        header?.setTitle("", for: .refreshing)
        header?.setTitle("", for: .willRefresh)
        header?.lastUpdatedTimeLabel.text = ""
        header?.lastUpdatedTimeText = { _ in return "" }
        header?.labelLeftInset = 0
        header?.ignoredScrollViewContentInsetTop = 10
        
        (self.slave as! UIScrollView).mj_header = header
    }
    
    func addFooter() {
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: {  [unowned self] in
            log.debug("🌟 Refresher 开始刷新")
            self.requestData(byFooter: true)
        })
        
        footer?.setTitle("", for: .idle)
        footer?.setTitle("--- 没有更多内容啦 ---", for: .noMoreData)
        footer?.setTitle("", for: .pulling)
        footer?.setTitle("", for: .refreshing)
        footer?.setTitle("", for: .willRefresh)
        footer?.labelLeftInset = 0
        footer?.stateLabel.textColor = Color(hexString: "dddddd")
        
        (self.slave as! UIScrollView).mj_footer = footer
    }
}
