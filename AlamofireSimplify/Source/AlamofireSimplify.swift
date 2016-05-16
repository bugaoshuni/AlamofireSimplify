//
//  AlamofireSimplify.swift
//  AlamofireSimplify
//
//  Created by jichanghe on 16/5/12.
//  Copyright © 2016年 hjc. All rights reserved.
//

import Foundation

public enum Method: String {
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}


public class AlamofireSimplify {
    
    public class func request(
        httpMethod: Method,
        _ urlString: String,
          parameters: [String: AnyObject]? = nil)
        -> Request
    {
        return Manager.sharedInstance.request(
            httpMethod,
            urlString: urlString,
            parameters: parameters
        )
    }

}
