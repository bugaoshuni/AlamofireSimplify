//
//  SessionDelegate.swift
//  AlamofireSimplify
//
//  Created by jichanghe on 16/5/12.
//  Copyright © 2016年 hjc. All rights reserved.
//

import Foundation

public class SessionDelegate: NSObject, NSURLSessionDelegate {
    
    private var tasks: [Int: TaskDelegate] = [:]
    
    subscript(task: NSURLSessionTask) -> TaskDelegate? {
        get {
            
            return tasks[task.taskIdentifier]
        }
        set {
            tasks[task.taskIdentifier] = newValue
        }
    }
    
    
    

}



extension SessionDelegate: NSURLSessionTaskDelegate {

    public func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        print("6、NSURLSessionTaskDelegate--didCompleteWithError")
        if let error = error {
            print(error.localizedDescription)
        }
        if let delegate = self[task] {
            delegate.URLSession(session, task: task, didCompleteWithError: error)
        }
        self[task] = nil //如果不加 这句话，TaskDelegate 里的deinit析构 就不会执行。Request 类 里的delegate 属性 不会被释放。   因为 Request 对象和 SessionDelegate 对象 都强引用了 Request 类 里的delegate 属性（TaskDelegate对象）。
    }
    
}


extension SessionDelegate: NSURLSessionDataDelegate {
    
    public func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        print("3、NSURLSessionDataDelegate--didReceiveData")
        if let delegate = self[dataTask] as? DataTaskDelegate {
            delegate.URLSession(session, dataTask: dataTask, didReceiveData: data)
        }
    }

}

