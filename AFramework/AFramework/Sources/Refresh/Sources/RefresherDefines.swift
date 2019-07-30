//
//  RefresherDefines.swift
//  AFramework
//
//  Created by abyss on 2019/5/6.
//

import SwiftyJSON

public typealias RefreshNetDataConvert = (_ netData: JSON ) -> [JSON]

public typealias shouldSendRequest = (
    _ refresher: Refresher,
    _ api: String) -> Bool

public typealias RefreshURLGenerator = (
    _ refresher: Refresher,
    _ api: String) -> JSON

public typealias RefreshRequest = (
    _ refresher: Refresher,
    _ byFooter: Bool,
    _ refreshData: JSON) -> Swift.Void

/**
 网络请求毁掉延迟, 如果页面已经销毁会崩溃
 deinit调用时, 记得将callback清除
 */
public typealias RefreshRequestDone = (
    _ refresher: Refresher,
    _ byFooter: Bool,
    _ data: JSON) -> Swift.Void

public typealias RefreshPreRequest = (
    _ refresher: Refresher,
    _ byFooter: Bool,
    _ arguments: Any) -> Bool

public typealias RefreshPostRequest = (
    _ refresher: Refresher,
    _ byFooter: Bool,
    _ arguments: Any) -> Swift.Void

public typealias shouldEmptyCustom = (_ refresher: Refresher) -> UIView
public typealias shouldEmptyPlain = (_ refresher: Refresher) -> (
    title: String?,
    description: String?,
    image: UIImage?,
    color: UIColor?
)
