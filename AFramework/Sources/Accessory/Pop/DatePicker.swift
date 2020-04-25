//
//  DatePicker.swift
//  xl
//
//  Created by 任超 on 2018/10/23.
//  Copyright © 2018 Abyss. All rights reserved.
//

import Foundation
import Sheeeeeeeeet
import PGDatePicker

/**
 筛选日期选择器(开始和结束)
 
 Example:
 
 let datePicker = DatePicker(vc: self)
 datePicker.show { (start, end) in
 print(start,end)
 }
 */
open class DatePicker: NSObject {
    
    var startDate: DateComponents?
    var endDate: DateComponents?
    
    weak var vc: UIViewController!
    
    public typealias DatePickerDone = (DateComponents, DateComponents) -> ()
    
    public func showFilterDatePicker(done: @escaping DatePickerDone) {
        
        var items = Array<MenuItem>()
        items.append(MenuTitle(title: "选择筛选日期"))
        
        if let date = startDate  {
            items.append(MenuItem(title: "选择开始日期 \(date.display())", value: 0, image: nil))
        } else {
            items.append(MenuItem(title: "选择开始日期", value: 0, image: nil))
        }
        
        if let date = endDate  {
            items.append(MenuItem(title: "选择结束日期 \(date.display())", value: 1, image: nil))
        } else {
            items.append(MenuItem(title: "选择结束日期", value: 1, image: nil))
        }
        
        items.append(OkButton(title: "确定"))
        items.append(CancelButton(title: "取消"))
        
        let menu = Menu(items: items)
        let sheet = ActionSheet(menu: menu) { (sheet, item) in
            if item is OkButton {
                if let start = self.startDate, let end = self.endDate {
                    done(start, end)
                } else {
                    Hud.show(type: .info, text: "请选择开始和结束时间")
                }
            } else if item is CancelButton {
                sheet.dismiss()
            } else {
                let tag = item.value as! Int
                
                let datePickerManager = PGDatePickManager()
//                datePickerManager.isShadeBackground = true
                datePickerManager.headerViewBackgroundColor = UIColor(hexString: "3168c5")
                datePickerManager.cancelButtonTextColor = .white
                datePickerManager.confirmButtonTextColor = .white
                datePickerManager.titleLabel.textColor = .white
                datePickerManager.titleLabel.text = (tag == 0 ? "选择开始日期":"选择结束日期")
                let datePicker = datePickerManager.datePicker!
                datePicker.datePickerMode = .date
                
                datePicker.selectedDate = { [weak self](date) in
                    
                    if tag == 0 {
                        self?.startDate = date
                    } else if tag == 1 {
                        self?.endDate = date
                    }
                    
                    self?.showFilterDatePicker(done: done)
                }
                
                
                self.vc.present(datePickerManager, animated: false, completion: nil)
            }
        }
        
        sheet.present(in: self.vc, from: self.vc.view)
    }
    
    public init(vc: UIViewController) {
        self.vc = vc
    }
}
