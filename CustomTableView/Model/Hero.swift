//
//  Hero.swift
//  CustomTableView
//
//  Created by 2B on 11/14/17.
//  Copyright © 2017 Automata. All rights reserved.
//

import Foundation
import Alamofire

class Hero {
    
    var name: String?
    var team: String?
    var imageUrl: String?
    
    init(name: String?, team: String?, imageUrl: String?) {
        self.name = name
        self.team = team
        self.imageUrl = imageUrl
    }
    
}
