//
//  UIView+Category.swift
//  AFramework
//
//  Created by abyss on 2019/5/2.
//

import Foundation
import Lottie

public extension UIView {
    

    static func welldone() -> AnimationView {
        let loading = AnimationView()
        let starAnimation = Animation.named("welldone")
        loading.animation = starAnimation
//        loading.loopMode = .playOnce
        loading.loopMode = .loop
        
        return loading
    }
    
    /**
      抖动动画
    */
    func pulse(_ value: Float = 1.2, _ min: Float = 0.8) {
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulse.duration = 0.1
        pulse.repeatCount = 1
        pulse.autoreverses = true;
        pulse.fromValue = NSNumber(value: min)
        pulse.toValue = NSNumber(value: value)
        
        self.layer.add(pulse, forKey:nil)
    }
    
    /**
     # 渐变色
     */
    func gradientColor(_ colorLeft: UIColor, _ colorRight: UIColor,_ startPoint: CGPoint, _ endPoint: CGPoint) {
        let gradientColors:[CGColor] = [colorLeft.cgColor,colorRight.cgColor]
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        
        //渲染的起始位置
        gradientLayer.startPoint = startPoint
        
        //渲染的终止位置
        gradientLayer.endPoint = endPoint
        
        //设置frame和插入view的layer
        
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /**
     圆角
     */
    func corner(
        _ corners: UIRectCorner = UIRectCorner.allCorners,
        _ radii: CGFloat = 5) {
        
        if corners == .allCorners {
            self.layer.cornerRadius = radii
            self.layer.masksToBounds = true
        } else {
            DispatchQueue.main.async {
                let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
                let maskLayer = CAShapeLayer()
                maskLayer.frame = self.bounds
                maskLayer.path = maskPath.cgPath
                self.layer.mask = maskLayer
            }
        }
    }
    
    func border(_ color: CGColor = UIColor.app_line.cgColor, _ width: CGFloat = 0.5) {
        self.layer.borderColor = color
        self.layer.borderWidth = width
    }
    
    /** 高清 截图功能 */
    func captureImage() -> UIImage! {
        let rect: CGRect = self.bounds;
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        
        let ctx = UIGraphicsGetCurrentContext()!
        self.layer.render(in: ctx)
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result ?? UIImage()
    }
}
