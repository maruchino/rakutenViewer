//
//  SearchManager.swift
//  rakutenViewer
//
//  Created by  intern on 2015/08/18.
//  Copyright (c) 2015年 sonicmoov. All rights reserved.
//

import UIKit

import Result

public class SearchManager: NSObject{
    
    
    lazy var client: APIClient = APIClient()
    
    public func searchItems(keyword: String, handler: Result<ItemsJSON, NSError> -> ()){
        client.request(SearchEndpoint(keyword: keyword), handler: handler)
    }
}

