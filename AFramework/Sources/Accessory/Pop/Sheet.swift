//
//  Sheet.swift
//  xl
//
//  Created by 任超 on 2018/10/23.
//  Copyright © 2018 Abyss. All rights reserved.
//

import Foundation
import Sheeeeeeeeet
import PGDatePicker

public class Sheet: NSObject {
    
     public typealias SelectAction = (ActionSheet, MenuItem) -> ()
    
    /**
     调用Sheet
 
     Example:
        Sheet.showSheet( title: "提示",
                         okButton: "确定",
                         cancelButton: "取消",
                         nameKey: "name",
                         items: [["name":"1"],
                                 ["name":"2"]],
                         vc: self) { (sheet, item) in
                            if item is OkButton {
                                
                            } else if item is CancelButton {
                                sheet.dismiss()
                            } else {
                                let tag = item.value as! Int
                                
                                
                                print(tag)
                            }
        }
     */
    @discardableResult
    public class func showSheet(title: String = "",
                         okButton: String = "",
                         cancelButton: String = "",
                         nameKey: String = "name",
                         items: Array<Dictionary<String,String>>,
                         vc: UIViewController,
                         event: @escaping SelectAction)
        -> ActionSheet
    {
        var list = Array<MenuItem>()
        
        if title.count > 0 {
            list.append(MenuTitle(title: title))
        }
        
        
        var tag = 0
        items.forEach { (item) in
            if let name = item[nameKey] {
                list.append(MenuItem(title: name, value: tag, image: nil))
            }
            tag = tag + 1
        }
        
        if okButton.count > 0 {
            list.append(OkButton(title: okButton))
        }
        
        if cancelButton.count > 0 {
            list.append(CancelButton(title: cancelButton))
        }
        
        let menu = Menu(items: list)
    
        let sheet = ActionSheet(menu: menu) { sheet, item in
            event(sheet, item)
        }
        
        sheet.present(in: vc, from: vc.view)
        
        return sheet
    }
}

