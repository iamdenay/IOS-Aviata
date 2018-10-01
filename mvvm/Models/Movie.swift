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
    var originalTitle:String?
    var score:Double?
    var votes:Int?
    var posterPath:String?
    var overview:String?
    var budget:Int?
    var releaseDate:String?
    var genres:[Genre]?
    var duration:Int?
    var actors:[Actor]?
    var similar:[Movie]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        originalTitle <- map["original_title"]
        score <- map["vote_average"]
        votes <- map["vote_count"]
        posterPath <- map["poster_path"]
        overview <- map["overview"]
        budget <- map["budget"]
        releaseDate <- map["release_date"]
        genres <- map["genres"]
        duration <- map["runtime"]
        actors <- map["credits.cast"]
        similar <- map["similar.results"]
    }
}
