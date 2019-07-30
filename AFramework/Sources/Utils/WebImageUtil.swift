//
//  WebImageUtil.swift
//  AFramework
//
//  Created by abyss on 2019/5/1.
//

import Kingfisher
import SwifterSwift

public class WebImageUtil {
    static func processURL(_ url: String, _ size: CGSize) -> URL? {
        
        guard url.count > 0 else {
            return nil
        }
        
        var url = url

        let h: Int = Int(size.height*2)
        let w: Int = Int(size.width*2)
        
        if w == 0 || h == 0 {
            // nothing
        } else {
            url = "\(url)?x-oss-process=image/resize,m_lfit,w_\(w),h_\(h)"
        }

        /** 已经处理过中文的Url */
        if url.contains("%") {
            return URL(string: url)
            /** 处理中文字符 */
        } else if let result = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
            return result
        } else {
            return nil
        }
    }
}
