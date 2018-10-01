//
//  Model.swift
//  mvvm
//
//  Created by Atabay Ziyaden on 9/27/18.
//  Copyright © 2018 IcyFlame Studios. All rights reserved.
//

import Foundation
import ObjectMapper

class Movie : Mappable {
    var id:Int?
    var title:String?
    var score:Double?
    var votes:Int?
    var posterPath:String?
    var overview:String?

    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        score <- map["vote_average"]
        votes <- map["vote_count"]
        posterPath <- map["poster_path"]
        overview <- map["overview"]
    }
}
