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
    @IBOutlet weak var repoStars: UILabel!
    @IBOutlet weak var repoForked: UILabel!
    @IBOutlet weak var repoCreated: UILabel!
    
    
    var eachRepo: Repository! {
        didSet {
            self.repoName.text = eachRepo.name
            self.repoDescription.text = eachRepo.description
            self.repoLanguage.text = eachRepo.language
            self.repoStars.text = "\(String(describing: eachRepo.stars))"
            self.repoForked.text = "\(String(describing: eachRepo.forked))"
            self.repoCreated.text = eachRepo.created
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
