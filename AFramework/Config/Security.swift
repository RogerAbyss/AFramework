//
//  Security.swift
//  Strawberry
//
//  Created by abyss on 2019/6/3.
//

import Foundation
import CryptoSwift

/**
 ## Security(安全相关)
 <br>
 略
 */
public class Security {
    public static let key = (
        aes_key: "ZSKJ========ZSKJ",
        aes_iv: "ZSKJ========ZSKJ",
        salt: "drt",
        password_salt: "====ZSKJ",
        rsa_key: "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCtxvV5eVFgIJ0gWFL/hefuIHxJ3BcBTaOub+DgI8XRaNNW7Bcam2O9OV3Jbi/nTVrX0G6oKrvcksq+iXjgmz7ZuncJNCke+TzkT9CYFCmnUg8IdNFdAQw2TdO8/oKkqB3KnFCFWfZpcp58WPscpDDUT8YL1xU56vl/IZrPouxRSwIDAQAB"
    )
    
    public class func aes() -> AES {
        let aes = try! AES(key: Security.key.aes_key.bytes,
                           blockMode: CBC(iv: Security.key.aes_iv.bytes),
                           padding: .pkcs5)
        
        return aes
    }
    
//    class func checkIsSafe() {
//        if User.latest().isLogin() {
//            let defaults = Defaults()
//            let key2 = Key<Bool>("my_securitycenter_fingerprintpwd")
//            let key1 = Key<Bool>("my_securitycenter_gesturespwd")
//
//            if (defaults.get(for: key2) ?? false) {
//                Security.checkTouchID() {}
//            } else if (defaults.get(for: key1) ?? false) {
//                Security.checkGestrue() {}
//            }
//        }
//    }
//
//    class func checkTouchID(_ event: @escaping EventCallback) {
//        BAKit_TouchID.ba_touchID(withContent: "此操作需要认证您的身份", cancelButtonTitle: nil, otherButtonTitle: nil, enabled: true) { (type, error, msg) in
//            if type == BAKit_TouchIDType.success {
//                event()
//            } else {
//                Security.checkGestrue() {}
//            }
//        }
//    }
//    
//    class func checkGestrue(_ event: @escaping EventCallback) {
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
//            let hasPwd = CLLockVC.hasPwd()
//            let nav = (UIApplication.shared.delegate as! AppDelegate).nav
//            if (hasPwd == true) {
//                let lock = CLLockVC.showVerifyLockVC(inVC: nav!, forgetPwdBlock: {
//                    //
//                }, successBlock: { (vc, pwd) in
//                    event()
//                    vc?.dismiss(animated: true, completion: nil)
//                })
//                nav?.present(lock!, animated: true, completion: nil)
//            }
//        })
//    }
}

