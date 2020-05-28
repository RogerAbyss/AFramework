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
        let header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            log.debug("🌟 Refresher 开始刷新")
            
            self?.requestData(byFooter: false)
        })
        
        header.setTitle("", for: .idle)
        header.setTitle("", for: .noMoreData)
        header.setTitle("", for: .pulling)
        header.setTitle("", for: .refreshing)
        header.setTitle("", for: .willRefresh)
        header.lastUpdatedTimeLabel?.text = ""
        header.lastUpdatedTimeText = { _ in return "" }
        header.labelLeftInset = 0
        header.ignoredScrollViewContentInsetTop = 10
        
        (self.slave as! UIScrollView).mj_header = header
    }
    
    func requestApi(_ byFooter: Bool = true) {
        requestData(byFooter: byFooter)
    }
    
    func addFooter(_ footerContent: String = "AFrameworkFooterContent".localized()) {
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: {  [weak self] in
            log.debug("🌟 Refresher 开始刷新")
            self?.requestData(byFooter: true)
        })
        
        var f = "--- 没有更多内容啦 ---"
        if footerContent.count > 0 && footerContent != "AFrameworkFooterContent" {
            f = footerContent
        }
        
        footer.setTitle("", for: .idle)
        footer.setTitle(f, for: .noMoreData)
        footer.setTitle("", for: .pulling)
        footer.setTitle("", for: .refreshing)
        footer.setTitle("", for: .willRefresh)
        footer.labelLeftInset = 0
        footer.stateLabel?.textColor = Color(hexString: "dddddd")
        
        (self.slave as! UIScrollView).mj_footer = footer
    }
}
