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
            guard let strongSelf = self else {return}
            switch result {
            case .Success(let heroesArr):
                strongSelf.items = heroesArr
                DispatchQueue.main.async {
                    completion()
                }
                
            case .Failure(let strErr):
                print(strErr)
            }
        }
    }
}
