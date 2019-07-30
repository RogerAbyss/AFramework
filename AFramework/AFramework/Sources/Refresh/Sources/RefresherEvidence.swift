//
//  RefresherEvidence.swift
//  ProjectName
//
//  Created by abyss on 2019/5/4.
//

import SwiftyJSON

public struct RefresherEvidence {
    public var list: [JSON]
    
    public var page: Int
    public var pageSize: Int
    public var done: Bool = false
    public var loading: Bool = false
    /** 表明加载过一次, 用于第一次进入列表不加载empty */
    public var used: Bool = false
    
    public init(page: Int = 0, pageSize: Int = 15) {
        self.page = page
        self.pageSize = pageSize
        
        self.list = []
    }
}
