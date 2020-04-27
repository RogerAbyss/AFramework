//
//  RefreshCenter.swift
//  AFramework
//
//  Created by abyss on 2019/5/6.
//

import SwiftyJSON

public extension Refresher {
    class func setDefualtURLGenerator(_ callback: RefreshURLGenerator!) {
        defaultUrlGeneratorBlock = callback
    }
    class func setDefualtNetDataConvert(_ callback: RefreshNetDataConvert!) {
        defaultNetDataConvertBlock = callback
    }
    class func setDefualtRequest(_ callback: RefreshRequest!) {
        defaultRequestBlock = callback
    }
    class func setDefualtRequestDone(_ callback: RefreshRequestDone!) {
        defaultRequestDoneBlock = callback
    }
    class func setDefualPreRequest(_ callback: RefreshPreRequest!) {
        defaultPreRequestBlock = callback
    }
    class func setDefualPostRequest(_ callback: RefreshPostRequest!) {
        defaultPostRequestBlock = callback
    }
    class func setDefualtShouldSendRequestBlock(_ callback: shouldSendRequest!) {
        defaultShouldSendRequestBlock = callback
    }
    class func setDefualtShouldEmptyBlock(_ callback: shouldEmptyPlain!) {
        defaultEmptyCallback = callback
    }
}

public extension Refresher {
    func headRequestHandler(_ data: AnyObject) {
        self.requestDataDone(data as! JSON, byFooter: false)
    }
    
    func footRequestHandler(_ data: AnyObject) {
        self.requestDataDone(data as! JSON, byFooter: true)
    }
    
    func failRequestHandler() {
         self.requestDataDone(JSON(), byFooter: false, isSuccess: false)
    }
}

public extension Refresher {
    func requestData(byFooter: Bool) {
        guard self.api.count > 0 else { log.info("🌟 api为空, 不刷新"); return }
        guard !self.evidence.loading else { log.info("🌟 加载中"); return }
        
        
        if byFooter&&self.evidence.done {
            if slave.isKind(of: UIScrollView.classForCoder()) {
                (slave as! UIScrollView).mj_footer?.endRefreshing()
            }
            
            log.debug("🌟 数据已经加载完毕, 请不要重复加载")
            return
        }
        
        guard self.shouldSendRequestBlock(self, self.api) else {
            log.info("🌟 阻止刷新")
            return
        }
        
        if !byFooter {
            self.evidence.done = false
            if let footer = (self.slave as! UIScrollView).mj_footer {
                footer.state = .idle
            }
        }
        
        self.evidence.page = byFooter ? self.evidence.page + 1 : 0
        
        let params = JSON([
            "b":self.urlGeneratorBlock(self, self.api),
            "p":"\(self.evidence.page)",
            "s":"\(self.evidence.pageSize)",
            "a":self.api
            ])
        
        self.plugins.forEach { [weak self] in
            if self != nil {
                 $0.willSend(refresher: self!, byFooter: byFooter)
            }
        }
        self.evidence.loading = true
        self.requestBlock(self, byFooter, params)
    }
    
    func requestDataDone(_ data: JSON, byFooter: Bool, isSuccess: Bool = true) {
        self.evidence.loading = false
        
        guard isSuccess == true else {
            self.postRequestBlock(self, byFooter, data)
            self.plugins.forEach { $0.didReceive(refresher: self, byFooter: byFooter) }
            self.requestDoneBlock(self, byFooter, data)
            
            return
        }
        
        if !self.preRequestBlock(self, byFooter, data) {
            self.requestDoneBlock(self, byFooter, data)
            
            return
        }

        let netData = self.netDataConvertBlock(data)
        
        if byFooter {
            self.evidence.done = (netData.count < self.evidence.pageSize)
            
            if self.evidence.done == true {
                log.debug("🌟 数据加载完毕")
            }
        } else {
            self.evidence.done = false
            self.evidence.list.removeAll()
        }
        
        netData.forEach { [weak self] in
            if self == nil {
                return
            }
            
            self!.evidence.list.append($0)
        }
        log.debug("🌟 Refresher 处理数据: 新增[\(netData.count)] 总共[\(self.evidence.list.count)]")
        
        self.postRequestBlock(self, byFooter, data)
        self.plugins.forEach { $0.didReceive(refresher: self, byFooter: byFooter) }
        self.requestDoneBlock(self, byFooter, data)
    }
}

public extension Refresher {
    static func setup() {
        Refresher.setDefualtShouldEmptyBlock { _ in return (nil, "ios_no_moredata".localized(), Assets.placeholder, nil) }
        Refresher.setDefualtURLGenerator { (_, _) -> JSON in return JSON([:]) }
        Refresher.setDefualPreRequest { (_, _, _) -> Bool in return true }
        Refresher.setDefualPostRequest { (_, _, _) in }
        Refresher.setDefualtRequestDone { (_, _, _) in }
        Refresher.setDefualtNetDataConvert { (data) -> [JSON] in return data.arrayValue }
        Refresher.setDefualtShouldSendRequestBlock { (_, _) in return true }
    }
}
