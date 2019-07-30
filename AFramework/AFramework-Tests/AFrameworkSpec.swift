//
//  AFrameworkTests.swift
//  AFrameworkTests
//
//  Created by abyss on 2019/4/21.
//  Copyright © 2019 abyss. All rights reserved.
//

import XCTest
@testable import AFramework

import Quick
import Nimble

import Alamofire
import MJRefresh
import SwiftyJSON
import SwiftyBeaver
import CryptoSwift
import SVProgressHUD
import Moya
import Result
import RxSwift
import Kingfisher

/**
 http请求测试
 https://httpbin.org/
 */
class AFrameworkSpec: QuickSpec {
    
    override func spec() {
        describe("测试Alamofire5") {
//            it("Get请求") {
//                waitUntil(timeout: 10) { done in
//                    AF.request("https://httpbin.org/get").responseJSON { (res) in
//                        expect(res.value).notTo(beNil(), description: "没有返回json数据")
//                        expect(res.response?.statusCode == 200).to(beTrue(), description: "状态码不是200")
//                        done()
//                    }
//                }
//            }
//            
//            it("Post请求") {
//                waitUntil(timeout: 10) { done in
//                    AF.request("https://httpbin.org/post", method: .post).responseJSON { (res) in
//                        expect(res.value).notTo(beNil(), description: "没有返回json数据")
//                        expect(res.response?.statusCode == 200).to(beTrue(), description: "状态码不是200")
//                        done()
//                    }
//                }
//            }
        }
        
        describe("测试Alamofire4") {
            it("Get请求") {
                waitUntil(timeout: 10) { done in
                    Alamofire.request("https://httpbin.org/get").responseJSON { (res) in
                        expect(res.value).notTo(beNil(), description: "没有返回json数据")
                        expect(res.response?.statusCode == 200).to(beTrue(), description: "状态码不是200")
                        done()
                    }
                }
            }
            
            it("Post请求") {
                waitUntil(timeout: 10) { done in
                    Alamofire.request("https://httpbin.org/post", method: .post).responseJSON { (res) in
                        expect(res.value).notTo(beNil(), description: "没有返回json数据")
                        expect(res.response?.statusCode == 200).to(beTrue(), description: "状态码不是200")
                        done()
                    }
                }
            }
        }
    }
}
