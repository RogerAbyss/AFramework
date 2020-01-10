//
//  Refresher.swift
//  ProjectName
//
//  Created by abyss on 2019/5/4.
//

import Moya
import SwiftyJSON

public class Refresher {
    public var api: String
    public var slave: AnyObject
    
    public var evidence: RefresherEvidence
    public var plugins: [RefreshPluginType]
    
    public var tag: String = ""
    public var emptyCustomCallback: shouldEmptyCustom?
    public var cancelable: Cancellable?
    
    public init(api: String! = "", slave: AnyObject!, _ plugins: [RefreshPluginType] = [RefreshPluginMJRefresh()]) {
        
        self.evidence = RefresherEvidence()
        if(slave.isKind(of: UITableView.classForCoder())) {
            log.debug("🌟 Refresher 托管了一个table")
            (slave as! UITableView).separatorStyle = .none
        } else if (slave.isKind(of: UICollectionView.classForCoder())) {
            log.debug("🌟 Refresher 托管了一个collection")
        } else if (slave.isKind(of: UIScrollView.classForCoder())) {
            log.debug("🌟 Refresher 托管了一个scrollview")
        } else {
            log.error("🌟 [不支持的类型] RefreshView is UITableView/UICollectionView/UIScrollView")
        }
        
        self.api = api
        self.slave = slave
        self.plugins = plugins
        
        self.handleEmpty()
    }
    
    static public var defaultEmptyCallback: shouldEmptyPlain?
    public var emptyCallback: shouldEmptyPlain = defaultEmptyCallback!
    
    static public var defaultShouldSendRequestBlock: shouldSendRequest?
    public var shouldSendRequestBlock :shouldSendRequest = defaultShouldSendRequestBlock!
    
    static public var defaultUrlGeneratorBlock: RefreshURLGenerator?
    public var urlGeneratorBlock :RefreshURLGenerator = defaultUrlGeneratorBlock!
    
    static public var defaultNetDataConvertBlock: RefreshNetDataConvert?
    public var netDataConvertBlock :RefreshNetDataConvert = defaultNetDataConvertBlock!
    
    static public var defaultRequestBlock: RefreshRequest?
    public var requestBlock :RefreshRequest = defaultRequestBlock!
    
    static public var defaultRequestDoneBlock: RefreshRequestDone?
    public var requestDoneBlock :RefreshRequestDone = defaultRequestDoneBlock!
    
    static public var defaultPreRequestBlock: RefreshPreRequest?
    public var preRequestBlock :RefreshPreRequest = defaultPreRequestBlock!
    
    static public var defaultPostRequestBlock: RefreshPostRequest?
    public var postRequestBlock :RefreshPostRequest = defaultPostRequestBlock!
    
    deinit {
        log.debug("🗑 [回收] 列表")
        cancelable?.cancel()
    }
}

public extension Refresher {
    func refresh(_ byFooter: Bool = false) {
        self.requestData(byFooter: byFooter)
    }
    
    func cancelEmpty() {
        (slave as! UIScrollView).emptyDataSetDelegate = nil
        (slave as! UIScrollView).emptyDataSetSource = nil
    }
}
