//
//  Response.swift
//  mvvm
//
//  Created by Atabay Ziyaden on 9/28/18.
//  Copyright © 2018 IcyFlame Studios. All rights reserved.
//

import Foundation
import ObjectMapper

class Response : Mappable {
    
    var results: [Movie]?
    var page: Int?
    var totalPages:Int?
    
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        results <- map["results"]
        page <- map["page"]
        totalPages <- map["total_pages"]
    }
}
