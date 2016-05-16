//
//  Result.swift
//  AlamofireSimplify
//
//  Created by jichanghe on 16/5/12.
//  Copyright © 2016年 hjc. All rights reserved.
//

import Foundation

public enum Result<Value, Error: ErrorType> {
    
    case Success(Value)
    case Failure(Error)
    
    public var isSuccess: Bool {
        switch self {
            case .Success:
                return true
            case .Failure:
                return false
        }
    }
    
    public var isFailure: Bool {
        return !isSuccess
    }
    
    public var value: Value? {
        switch self {
            case .Success(let value):
                return value
            case .Failure:
                return nil
        }
    }
    
    public var error: Error? {
        switch self {
            case .Success:
                return nil
            case .Failure(let error):
                return error
        }
    }
    
}