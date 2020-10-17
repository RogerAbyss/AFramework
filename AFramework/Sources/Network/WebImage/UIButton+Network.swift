//
//  UIButton+Network.swift
//  ProjectName
//
//  Created by abyss on 2019/5/16.
//

import Kingfisher

public extension UIButton {
    func requestImageUrl(_ url: String,
                         _ mockType: MockImageType = .avatar,
                         _ usePlaceHolder: Bool = true,
                         resize: CGSize = CGSize(width: 0, height: 0),
                         processor: ImageProcessor = DefaultImageProcessor.default) {
        
        var url = url
        if M.shared.config.network.imagemock_enable {
            url = MockUtil.mockImg(mockType)
        }

        let modifier = AnyModifier { request in
            return request
        }

        var size = CGSize()
        if resize.width > 0 && resize.height > 0 {
            size = resize
        } else {
            size = self.size
        }

        let resource: Resource? = WebImageUtil.processURL(url, size)
        
        self.kf.setImage(with: resource,
                         for: .normal,
                         placeholder: usePlaceHolder ? PlaceHolderView.place(self).icon.image : nil,
                         options: [
                            .processor(processor),
                            .targetCache(CacheService.default.imageCache!),
                            .transition(.fade(0.4)),
                            .requestModifier(modifier)
        ]) { result in
            switch result {
            //                case .success: break
            case .success(let value):
                if M.shared.config.network.log_image {
                    log.info("🍀 \(value.source.url!.description) \n size:\(value.image.size)")
                }
                break
            case .failure(let error):
                log.debug("🔥 图片加载失败 \(error.errorDescription!.description)")
                break
            }
        }
    }
}

