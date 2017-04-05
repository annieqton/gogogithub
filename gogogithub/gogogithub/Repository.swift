//
//  Repository.swift
//  gogogithub
//
//  Created by Annie Ton-Nu on 4/4/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import Foundation

class Repository {
    
    let name: String
    let description: String?
    let language: String?
    let stars: Int?
    let forked: Bool?
    let created: String?
    
    var repo: Repository?
    
    init?(json: [String: Any]) {
        //parse json here for lab
        
        guard let name = json["name"] as? String else { return nil }
        self.name = name
        
        if let description = json["description"] as? String,
            let language = json["language"] as? String,
            let stars = json["targazers_count"] as? Int?,
            let forked = json["forks_count"] as? Bool,
            let created = json["created_at"] as? String?
        {
            self.description = description
            self.language = language
            self.stars = stars
            self.forked = forked
            self.created = created
            
        } else {
            self.description = "No description available"
            self.language = "No specified language"
            self.stars = 0
            self.forked = false
            self.created = "No date available"
        }
    }
}
