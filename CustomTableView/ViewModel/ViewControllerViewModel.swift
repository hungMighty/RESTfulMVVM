//
//  ViewControllerViewModel.swift
//  CustomTableView
//
//  Created by 2B on 11/14/17.
//  Copyright © 2017 Automata. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ViewControllerViewModel: NSObject {
    
    var items = [Hero]()
    
    func getHeroes(completion: @escaping () ->()) {
        APIClient.shared.fetchHeroesList { [weak self] (result) in
            switch result {
            case .Success(let heroDicts):
                if let heroDicts = heroDicts  {
                    for i in 0..<heroDicts.count {
                        self?.items.append(Hero(name: heroDicts[i]["name"].stringValue,
                                               team: heroDicts[i]["team"].stringValue,
                                               imageUrl: heroDicts[i]["imageurl"].stringValue))
                    }
                    DispatchQueue.main.async {
                        completion()
                    }
                }
                
            case .Failure(let strErr):
                print(strErr)
            }
        }
    }
}
