//
//  SSLUtil.swift
//  AFramework
//
//  Created by abyss on 2019/4/30.
//

import UIKit

/**
 get *.crt
 openssl x509 -in *.crt -out *.cer -outform der
 */
public class SSLUtil {
    public static var useSSL: Bool = M.shared.config.ssl.ssl_enable
    public static var trustHost: String = M.shared.config.ssl.ssl_trust
}
