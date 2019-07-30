//
//  RefreshPluginMJRefresh.swift
//  AFramework
//
//  Created by abyss on 2019/5/6.
//

import MJRefresh

public class RefreshPluginMJRefresh: RefreshPluginType {
    public init() {}
    
    public func willSend(refresher: Refresher, byFooter: Bool) {
        if refresher.slave.isKind(of: UITableView.classForCoder()) {
            if (refresher.slave as! UITableView).tableFooterView == nil {
                (refresher.slave as! UITableView).tableFooterView = UIView()
            }
        } else if refresher.slave.isKind(of: UICollectionView.classForCoder()) {
        }
    }
    
    public func didReceive(refresher: Refresher, byFooter: Bool) {
        refresher.evidence.used = true
        
        if byFooter {
            if let footer = (refresher.slave as! UIScrollView).mj_footer {
                log.debug("🌟 Refresher 停止刷新")
                footer.isHidden = (refresher.evidence.list.count == 0)
                refresher.evidence.done ? footer.endRefreshingWithNoMoreData(): footer.endRefreshing()
            }
        } else {
            if let header = (refresher.slave as! UIScrollView).mj_header {
                log.debug("🌟 Refresher 停止刷新")
                header.endRefreshing()
            }
        }
        
        if refresher.slave.isKind(of: UITableView.classForCoder()) {
            (refresher.slave as! UITableView).reloadData()
            (refresher.slave as! UITableView).reloadEmptyDataSet()
        } else if refresher.slave.isKind(of: UICollectionView.classForCoder()) {
            (refresher.slave as! UICollectionView).reloadData()
            (refresher.slave as! UICollectionView).reloadEmptyDataSet()
        }
    }
}
