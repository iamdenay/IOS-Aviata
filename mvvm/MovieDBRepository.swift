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
    func getPopular(page:Int,completion: @escaping (Response) -> ()){
        
        let reqURL = "https://api.themoviedb.org/3/movie/popular"

        let parameters: Parameters = [
            "api_key": "1f6c189d328933bfd0c9b198db3f97a8",
            "page":page
        ]
            
        Alamofire.request(reqURL, parameters: parameters).responseObject { (response: DataResponse<Response>) in
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
            "api_key": "1f6c189d328933bfd0c9b198db3f97a8",
            "append_to_response":"credits,similar"
        ]
        
        
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
    
    func getFilteredByYear(min:Int,max:Int, completion: @escaping ([Movie]) -> ()){
        
        let reqURL = "https://api.themoviedb.org/3/discover/movie"

        let parameters: Parameters = [
            "api_key": "1f6c189d328933bfd0c9b198db3f97a8",
            "release_date.gte":"\(min)-01-01",
            "release_date.lte":"\(max)-12-31",
            "sort_by":"release_date.asc"
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
    
    func getImages(identifier: Int, completion: @escaping ([MovieImage]) -> ()){
        
        let reqURL = "https://api.themoviedb.org/3/movie/\(identifier)/images"

        let parameters: Parameters = [
            "api_key": "1f6c189d328933bfd0c9b198db3f97a8",
            "include_image_language":"en"
        ]
        
        Alamofire.request(reqURL, parameters: parameters).responseArray(keyPath:"backdrops") { (response: DataResponse<[MovieImage]>) in
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
    
    func getByGenre(identifier:Int, completion: @escaping ([Movie]) -> ()){
        
        let reqURL = "https://api.themoviedb.org/3/discover/movie"

        let parameters: Parameters = [
            "api_key": "1f6c189d328933bfd0c9b198db3f97a8",
            "language":"en-US",
            "sort_by":"popularity.desc",
            "include_adult":"false", // false? :)
            "include_video":"false",
            "with_genres":"\(identifier)"
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
    
    func searchByName(query:String, completion: @escaping ([Movie]) -> ()){
        
        let reqURL = "https://api.themoviedb.org/3/search/movie"

        let parameters: Parameters = [
            "api_key": "1f6c189d328933bfd0c9b198db3f97a8",
            "language":"en-US",
            "include_adult":"false", // false? :)
            "query":query
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
    
    

}
