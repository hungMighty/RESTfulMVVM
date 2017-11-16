//
//  Hero.swift
//  CustomTableView
//
//  Created by 2B on 11/14/17.
//  Copyright © 2017 Automata. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Hero: Codable {
    
    var name: String?
    var team: String?
    var imageurl: String?
    
    init(name: String?, team: String?, imageUrl: String?) {
        self.name = name
        self.team = team
        self.imageurl = imageUrl
    }
    
    init?(json: JSON) {
        guard let name = json["name"].string,
            let team = json["team"].string,
            let imageUrl = json["imageurl"].string else {
                return nil
        }
        
        self.name = name
        self.team = team
        self.imageurl = imageUrl
    }
    
}
