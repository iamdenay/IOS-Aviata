//
//  MovieDBRepository.swift
//  mvvm
//
//  Created by Atabay Ziyaden on 9/27/18.
//  Copyright © 2018 IcyFlame Studios. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class MovieDBRepository {
    func getPopular(completion: @escaping ([Movie]) -> ()){
        
        let reqURL = "https://api.themoviedb.org/3/movie/popular"

        let parameters: Parameters = [
            "api_key": "1f6c189d328933bfd0c9b198db3f97a8"
        ]
            
        Alamofire.request(reqURL, parameters: parameters).responseArray(keyPath:"results") { (response: DataResponse<[Movie]>) in
            print("Request: \(String(describing: response.request!))")
            print("Response: \(String(describing: response.response!))")
            print("Error: \(String(describing: response.error))")
            print("Result: \(response.result)")
            
            if let res = response.result.value {
                completion(res)
            }
        }
    }
    
    func getUpcoming(completion: @escaping ([Movie]) -> ()){
        
        let reqURL = "https://api.themoviedb.org/3/movie/upcoming"
        
        let parameters: Parameters = [
            "api_key": "1f6c189d328933bfd0c9b198db3f97a8"
        ]
        
        var movies : [Movie] = []
        
        Alamofire.request(reqURL, parameters: parameters).responseArray(keyPath:"results") { (response: DataResponse<[Movie]>) in
            print("Request: \(String(describing: response.request!))")
            print("Response: \(String(describing: response.response!))")
            print("Error: \(String(describing: response.error))")
            print("Result: \(response.result)")
            
            if let res = response.result.value {
                completion(res)
            }
            
        }
    }
    func getMovie( identifier:Int, completion: @escaping (Movie) -> ()){
        
        let reqURL = "https://api.themoviedb.org/3/movie/\(identifier)"
        
        let parameters: Parameters = [
            "api_key": "1f6c189d328933bfd0c9b198db3f97a8"
        ]
        
        var movie : Movie?
        
        Alamofire.request(reqURL, parameters: parameters).responseObject { (response: DataResponse<Movie>) in
            print("Request: \(String(describing: response.request!))")
            print("Response: \(String(describing: response.response!))")
            print("Error: \(String(describing: response.error))")
            print("Result: \(response.result)")
            
            if let res = response.result.value {
                completion(res)
            }
            
        }
    }
    func getGenres(completion: @escaping ([Genre]) -> ()){
        let reqURL = "https://api.themoviedb.org/3/genre/movie/list"
        
        let parameters: Parameters = [
            "api_key": "1f6c189d328933bfd0c9b198db3f97a8"
        ]
        
        var genres : [Genre] = []
        
        Alamofire.request(reqURL, parameters: parameters).responseArray(keyPath:"genres") { (response: DataResponse<[Genre]>) in
            print("Request: \(String(describing: response.request!))")
            print("Response: \(String(describing: response.response!))")
            print("Error: \(String(describing: response.error))")
            print("Result: \(response.result)")
            
            if let res = response.result.value {
                completion(res)
            }
            
        }
    }

}
