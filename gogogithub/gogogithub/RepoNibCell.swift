//
//  RepoNibCell.swift
//  gogogithub
//
//  Created by Annie Ton-Nu on 4/5/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit

class RepoNibCell: UITableViewCell {

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
