//
//  APIClient.swift
//  CustomTableView
//
//  Created by 2B on 11/14/17.
//  Copyright © 2017 Automata. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum APIResult<T> {
    case Success(T)
    case Failure(String)
}

class APIClient {
    
    static let shared = APIClient()
    private init() {}
    
    func fetchHeroesList(completion: @escaping (APIResult<[JSON]?>) -> Void) {
        guard let url = URL(string: "https://simplifiedcoding.net/demos/marvel/") else {
            print("Error unwrapping URL")
            return
        }
        
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let heroesArr = JSON(value).array else {return}
                completion(.Success(heroesArr))
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

}
