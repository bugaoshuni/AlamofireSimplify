//
//  ViewController.swift
//  AlamofireSimplify
//
//  Created by jichanghe on 16/5/12.
//  Copyright © 2016年 hjc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func testSimplifyTap(sender: UIButton) {
        
//        //测试一：
        AlamofireSimplify.request(Method.GET, "https://httpbin.org/get")
            .responseString { response in
            if response.result.isFailure {
                let error = response.result.error!
                print(error.localizedDescription)
                return
            } else {
                let value = response.result.value!
                print(value)
            }
        }
//
        //测试二：
//        let request = AlamofireSimplify.request(Method.GET, "https://httpbin.org/get")
////        sleep(10)
////        print("sleep(10)")
//        request.responseString {
//            print("结束，接口返回结果：")
//            if $0.result.isFailure {
//                let error = $0.result.error!
//                print(error.localizedDescription)
//                return
//            } else {
//                let value = $0.result.value!
//                print(value)
//            }
//        }
        
        
    }

}

