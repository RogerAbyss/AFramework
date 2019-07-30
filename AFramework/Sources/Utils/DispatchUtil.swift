//
//  DispatchUtil.swift
//  AFramework
//
//  Created by abyss on 2019/4/30.
//

import UIKit

public class DispatchUtil: NSObject {
    
    public typealias Task = (_ cancel : Bool) -> Void
    
    @discardableResult
    static public func delay(_ time: TimeInterval, task: @escaping ()->()) -> Task? {
        
        func dispatch_later(block: @escaping ()->()) {
            let t = DispatchTime.now() + time
            DispatchQueue.main.asyncAfter(deadline: t, execute: block)
        }
        var closure: (()->Void)? = task
        var result: Task?
        
        let delayedClosure: Task = {
            cancel in
            if let internalClosure = closure {
                if (cancel == false) {
                    DispatchQueue.main.async(execute: internalClosure)
                }
            }
            closure = nil
            result = nil
        }
        
        result = delayedClosure
        
        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(false)
            }
        }
        
        return result
    }
    
    static public func cancel(_ task: Task?) {
        task?(true)
    }

}
