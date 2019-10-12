//
//  Alert.swift
//  xl
//
//  Created by 任超 on 2018/9/13.
//  Copyright © 2018年 Abyss. All rights reserved.
//

import Foundation
import YPImagePicker
import SwiftyJSON
import PopupDialog

public class Alert: NSObject {
    /**
     调用Alert
    */
    public class func showAlert(
        buttons: Array<String> = ["AFrameworkNoteEnsure".localized()], //确定
        title: String = "AFrameworkNoteNote".localized(), //提示
        message: String = "",
        cancelName: String = "AFrameworkNoteCancel".localized(), // 取消
        _ vc: UIViewController = M.shared.nav!,
        event: @escaping EventTagCallback) {
        
        let popup = PopupDialog(title: title, message: message)
        
        let cancel = CancelButton(title: cancelName) {
            vc.dismiss(animated: true, completion: nil)
        }
        
        popup.addButton(cancel)
        
        var tag = 0
        for buttonName in buttons {
            let button = DefaultButton(title: buttonName) {
                event(tag)
            }
            
            button.setTitleColor(.app_tintColor, for: .normal)
            
            tag = tag + 1
            popup.addButton(button)
        }
                
        vc.present(popup, animated: true, completion: nil)
    }
    
    public class func showAlertSimple(
        cancelName: String = "AFrameworkNoteEnsure".localized(), //确定
        title: String = "AFrameworkNoteNote".localized(), //提示
        message: String,
        _ vc: UIViewController = M.shared.nav!) {
        
        let popup = PopupDialog(title: title, message: message)
        
        let cancel = CancelButton(title: cancelName) {
            vc.dismiss(animated: true, completion: nil)
        }
        
        popup.addButton(cancel)
        
        vc.present(popup, animated: true, completion: nil)
    }
    
    /**
     调用ActionSheet
     */
    
    
    /**
     调用系统相机
    */
    public class func showCarmera(_ title: String? = nil,
                          _ message: String? = nil,
                          _ preferredStyle: UIAlertController.Style = .actionSheet,
                          _ maxSelect: Int = 1,
                          _ minSelect: Int = 1,
                          _ hasTakePhoto: Bool = true,
                          vc: UIViewController,
                          takePhoto: @escaping EventJSONCallback,
                          choosePhoto: @escaping EventJSONCallback) -> UIAlertController {
        let action = UIAlertController.init(title: title, message: message, preferredStyle: preferredStyle)
        
        /**
         添加按钮 - 照相
        */
        if(hasTakePhoto) {
            // 拍照
            action.addAction(UIAlertAction.init(title: "AFrameworkNoteCamera".localized(), style:UIAlertAction.Style.default, handler: { (_) in
                var config = YPImagePickerConfiguration()
                config.screens = [.photo]
                let picker = YPImagePicker(configuration: config)
                
                picker.didFinishPicking { [unowned picker] items, _ in
                    if let photo = items.singlePhoto {
                        
                        if let data = photo.image.jpegData(compressionQuality: 0.4) {
                            /** 上传图片 */
//                            data.upload(callback: { (json) in
//                                print("🎃 上传图片:" + json["src"].stringValue.imgUrl())
//                                takePhoto(json)
//                            })
                        }
                    }
                    
                    picker.dismiss(animated: true, completion: nil)
                }
                
                vc.present(picker, animated: true, completion: nil)
            }))
        }
        
        /**
         添加按钮 - 选择照片
         */
        
        // 选择照片
        action.addAction(UIAlertAction.init(title: "AFrameworkNoteChoosePhoto".localized(), style:UIAlertAction.Style.default, handler: { (_) in
            var config = YPImagePickerConfiguration()
            config.screens = [.library]
            config.library.maxNumberOfItems = maxSelect
            config.library.minNumberOfItems = minSelect
            
            let picker = YPImagePicker(configuration: config)
            
            picker.didFinishPicking { [unowned picker] items, _ in
                if let photo = items.singlePhoto {
                    
                    if let data = photo.image.jpegData(compressionQuality: 0.4) {
                        /** 上传图片 */
//                        data.upload(callback: { (json) in
//                            print("🎃 上传图片:" + json["src"].stringValue.imgUrl())
//                            takePhoto(json)
//                        })
                    }
                }
                
                picker.dismiss(animated: true, completion: nil)
            }
            
            vc.present(picker, animated: true, completion: nil)
        }))
        
        // 取消
        action.addAction(UIAlertAction.init(title: "AFrameworkNoteCancel".localized(), style:UIAlertAction.Style.cancel, handler: nil))
        vc.present(action, animated: true, completion: nil)
        
        return action
    }
}
