//
//  APIClient.swift
//  rakutenViewer
//
//  Created by  intern on 2015/08/18.
//  Copyright (c) 2015年 sonicmoov. All rights reserved.
//
import UIKit
import Alamofire
import Result
import Mantle

public class APIClient: NSObject{
    
    let baseURLString:String
    public convenience override init(){
        self.init ( baseURLString:"https://app.rakuten.co.jp")
    }
    
    public init(baseURLString: String) {
        self.baseURLString = baseURLString
    }
    
    public func request<T: Endpoint>(endpoint: T, handler: Result<T.Response, NSError> -> ()) {
        Alamofire.request(endpoint.method, baseURLString + endpoint.path, parameters: endpoint.parameters)
            .validate()
            .responseJSON { (_, _, JSON, error) in
                if let e = error {
                    handler(Result.failure(e))
                } else {
                    handler(endpoint.parser(JSON))
                }
        }
    }
}

