//
//  RepoDetailController.swift
//  gogogithub
//
//  Created by Annie Ton-Nu on 4/5/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit

class RepoDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var repoFeedTableView: UITableView!
    
    var eachRepo : Repository!

    var allRepos = [Repository](){
        didSet{
            repoFeedTableView.reloadData()
        }
    }
        

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.repoFeedTableView.dataSource = self
        self.repoFeedTableView.delegate = self
        
        let repoNib = UINib(nibName: "RepoNibCell", bundle: nil)
        self.repoFeedTableView.register(repoNib, forCellReuseIdentifier: RepoNibCell.identifier)
        
        self.repoFeedTableView.estimatedRowHeight = 50
        self.repoFeedTableView.rowHeight = UITableViewAutomaticDimension
        
        update()
        
    }
    
    func update() {
        GitHub.shared.getRepos { (allRepos) in
            if allRepos != nil{
                OperationQueue.main.addOperation {
                self.allRepos = allRepos!
                }
            }
        }
    }
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRepos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = repoFeedTableView.dequeueReusableCell(withIdentifier: RepoNibCell.identifier, for: indexPath) as! RepoNibCell

        let eachRepo = self.allRepos[indexPath.row]
        cell.eachRepo = eachRepo
        
        return cell
    }
    

}
