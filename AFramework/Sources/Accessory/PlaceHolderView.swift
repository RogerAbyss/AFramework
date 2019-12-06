//
//  PlaceHolderView.swift
//  AFramework
//
//  Created by abyss on 2019/5/1.
//

import Kingfisher
import SnapKit

public class PlaceHolderView: UIView {
    var icon: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        icon = UIImageView()
        self.addSubview(icon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public class func place(_ view: UIView!, _ imageName: String="") -> PlaceHolderView {
        let placeholder = PlaceHolderView(frame: CGRect.init(x: 0, y: 0, width: view.width, height: view.height))
        
        var source_image: UIImage?
        if imageName.count > 1 {
            source_image = UIImage(named: imageName)
        } else {
            source_image = Assets.placeholder
        }
        
        /** 背景色防止图片重用 */
        placeholder.backgroundColor = .app_background
//        placeholder.icon.width = min(view.width/2, (source_image?.size.width)!)
//        placeholder.icon.height = min(view.height/2, (source_image?.size.height)!)
        placeholder.icon.image = source_image
        
        // 适应最大比例
        let maxScale: CGFloat = 0.7
        let minSideOfView: CGFloat = min(view.width, view.height)
        let maxSideOfHolder: CGFloat = max(source_image!.size.width, source_image!.size.height)
        
        var scale: CGFloat = 1.0
        
        if maxSideOfHolder > minSideOfView*maxScale {
            scale = minSideOfView*maxScale / maxSideOfHolder
        }
        
        // 真实的宽和高
        let w: CGFloat = source_image!.size.width * scale
        let h: CGFloat = source_image!.size.height * scale

        placeholder.icon.snp.makeConstraints { (make) in
            make.width.equalTo(w)
            make.height.equalTo(h)
            make.center.equalTo(placeholder)
        }
        
        placeholder.layoutIfNeeded()
        return placeholder
    }
}

extension PlaceHolderView: Placeholder {
}
