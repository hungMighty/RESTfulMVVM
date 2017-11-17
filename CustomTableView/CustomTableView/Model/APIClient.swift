//
//  APIClient.swift
//  CustomTableView
//
//  Created by 2B on 11/14/17.
//  Copyright © 2017 Automata. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum APIResult<T> {
    case Success(T)
    case Failure(String)
}

class APIClient {
    
    static let shared = APIClient()
    private init() {}
    
    func fetchHeroesList(completion: @escaping (APIResult<[Hero]?>) -> Void) {
        guard let url = URL(string: "https://simplifiedcoding.net/demos/marvel/") else {
            print("Error unwrapping URL")
            return
        }
        
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    if let myData = response.data {
                        let heroesArr = try decoder.decode([Hero].self, from: myData)
                        completion(.Success(heroesArr))
                    }
                } catch let err {
                    print("error trying to convert data to JSON")
                    print(err.localizedDescription)
                }
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

}
