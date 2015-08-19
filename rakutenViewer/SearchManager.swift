//
//  manager.swift
//  rakutenViewer
//
//  Created by  intern on 2015/08/18.
//  Copyright (c) 2015年 sonicmoov. All rights reserved.
//

import UIKit

import Result

public class SearchManager: NSObject{
    private typealias Response = Result<[ItemJSON], NSError>
    
    lazy var client: APIClient = APIClient()
    
    public func searchItems(keyword: String, handler: Result<ItemsJSON, NSError> -> ()){
        client.request(SearchEndpoint(keyword: keyword), handler: handler)
    }
}

