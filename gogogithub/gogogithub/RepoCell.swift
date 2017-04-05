//
//  RepoCell.swift
//  gogogithub
//
//  Created by Annie Ton-Nu on 4/4/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {
    
    
    
    @IBOutlet weak var repoName: UILabel!

    @IBOutlet weak var repoDescription: UILabel!

    @IBOutlet weak var repoLanguage: UILabel!
    
    var eachRepo: Repository! {
        didSet {
            self.repoName.text = eachRepo.name
            self.repoDescription.text = eachRepo.description
            self.repoLanguage.text = eachRepo.language
            
            
        }
    }
    
}
