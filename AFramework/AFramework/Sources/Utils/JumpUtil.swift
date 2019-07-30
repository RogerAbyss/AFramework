//
//  JumpUtil.swift
//  AFramework
//
//  Created by abyss on 2019/5/26.
//

import Foundation


public protocol Jumpable {
    static var jumpIdentifier: String { get }
}

public class JumperUtil {
    public static func jumpTo(
        storyboard: String,
        identifier: String,
        _ animated: Bool = true,
        _ modelWillPush: @escaping EventControllerCallback = {_ in}) {
        
        let vc = UIStoryboard(name: storyboard, bundle: Bundle.main)
            .instantiateViewController(withIdentifier: identifier)
        
        modelWillPush(vc)
        M.shared.nav?.pushViewController(vc, animated: animated)
    }
}
