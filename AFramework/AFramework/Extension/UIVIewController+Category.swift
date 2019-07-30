//
//  UIVIewController+Category.swift
//  AFramework
//
//  Created by abyss on 2019/5/1.
//

import UIKit

/**
 # UIViewController 方法拓展
 */
public extension UIViewController {
    @IBAction func back(segue: UIStoryboardSegue) {
        self.navigationController?.popViewController(animated: true)
    }
}
