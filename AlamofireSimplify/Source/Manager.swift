//
//  Manager.swift
//  AlamofireSimplify
//
//  Created by jichanghe on 16/5/12.
//  Copyright © 2016年 hjc. All rights reserved.
//

import Foundation

public class Manager {
    // MARK: - Properties
    public static let sharedInstance: Manager = {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        return Manager(configuration: configuration)
    }()
    
    public let session: NSURLSession
    public let sessionDelegate: SessionDelegate
    
    // MARK: - Lifecycle
    init(configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration(),
         sessionDelegate: SessionDelegate = SessionDelegate()) {
        session = NSURLSession(configuration: configuration, delegate: sessionDelegate, delegateQueue: nil)
        self.sessionDelegate = sessionDelegate
    }
    
    deinit {
        print("Manager deinit")
        session.invalidateAndCancel()
    }
    
    // MARK: - PublicMethod
    public func request(
        httpMethod: Method,
        urlString: String,
        parameters: [String: AnyObject]? = nil)
        -> Request
    {
        let mutableRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        mutableRequest.HTTPMethod = httpMethod.rawValue
        
        let task = session.dataTaskWithRequest(mutableRequest)
        let request = Request(session: session, task: task)
        sessionDelegate[task] = request.delegate
        task.resume()   //同： request.delegate.task.resume()
        return request
    }
    
}