//
//  Size.swift
//  AFramework
//
//  Created by abyss on 2019/7/25.
//

import Foundation

public class Size {
    public static var safeTop: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return 20 + UIApplication.shared.keyWindow!.safeAreaInsets.top
            } else {
                return 20
            }
        }
    }
}

