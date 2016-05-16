//
//  Request.swift
//  AlamofireSimplify
//
//  Created by jichanghe on 16/5/12.
//  Copyright © 2016年 hjc. All rights reserved.
//

import Foundation

public class Request {
    
    // MARK: - Properties
    public let session: NSURLSession
    public let delegate: TaskDelegate   
    
    public var response: NSHTTPURLResponse? {
        return delegate.task.response as? NSHTTPURLResponse
    }
    
    // MARK: - Lifecycle
    init(session: NSURLSession, task: NSURLSessionTask) {
        self.session = session
        
        switch task {
//            case is NSURLSessionUploadTask:
//                print("暂不支持上传")
            case is NSURLSessionDataTask:
                delegate = DataTaskDelegate(task: task)
//            case is NSURLSessionDownloadTask:
//                print("暂不支持下载")
            default:
                delegate = TaskDelegate(task: task)
        }
        
    }
    
    deinit {
        print("Request --deinit")
    }
    
    // MARK: - PublicMethod
    public func responseString(closure: Response<String, NSError> -> Void) -> Self {
        delegate.queue.addOperationWithBlock {
            let result: Result<String, NSError> = {
                if let error = self.delegate.error {
                    return .Failure(error)
                } else {
                    return .Success(String(data: self.delegate.data!, encoding: NSUTF8StringEncoding)!)
                }
            }()
            
            print("result = \(result)")
            let response = Response(request: self.delegate.task.originalRequest, response: self.response, data: self.delegate.data, result: result)
            
            dispatch_async(dispatch_get_main_queue()) { closure(response) }
        }
        return self
    }

}


public class TaskDelegate: NSObject {
    
    // MARK: - Properties
    public let queue: NSOperationQueue
    public let task: NSURLSessionTask
    public let progress: NSProgress
    public var data: NSMutableData?
    public var error: NSError?
    public var uploadStream: NSInputStream?
    
    // MARK: - Lifecycle
    init(task: NSURLSessionTask) {
        self.task = task
        progress = NSProgress(totalUnitCount: 0)
        queue = {
            let operationQueue = NSOperationQueue()
            operationQueue.maxConcurrentOperationCount = 1
            operationQueue.suspended = true
            return operationQueue
        }()
    }
    
    deinit {
        print("TaskDelegate deinit --取消queue")
        queue.cancelAllOperations()
        queue.suspended = false
    }
    
    // MARK: - PublicMethod
    public func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        print("007TaskDelegate-- didCompleteWithError")
        if let error = error {
            self.error = error
        }
        queue.suspended = false //
    }
    
}


public class DataTaskDelegate: TaskDelegate {
    
    // MARK: - Properties
    public var dataTask: NSURLSessionDataTask? {
        return task as? NSURLSessionDataTask
    }
    
    public var expectedContentLength: Int64?
    public var totalBytesReceived: Int64 = 0

    // MARK: - PublicMethod
    public func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        print("004、DataTaskDelegate--didReceiveData")
        if self.data == nil {
            self.data = NSMutableData()
        }
        self.data?.appendData(data)
    }
    
}




