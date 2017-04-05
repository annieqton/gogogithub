//
//  RepoViewController.swift
//  gogogithub
//
//  Created by Annie Ton-Nu on 4/4/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate {

    @IBOutlet weak var repoTableView: UITableView!
    
    var allRepos = [Repository](){
        didSet {
            repoTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.repoTableView.dataSource = self
        self.repoTableView.delegate = self
        
        update()
        
    }

    func update() {
        print("<--------update repo controller here--------->")
        GitHub.shared.getRepos { (repositories) in
            //update TableView with the repositories you get back
            if let repositories = repositories {
                self.allRepos = repositories
            }
        }
        
    }
    
}



extension RepoViewController : UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.identifier, for: indexPath) as! RepoCell
        let eachRepo = self.allRepos[indexPath.row]
            cell.eachRepo = eachRepo
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return allRepos.count
    }
    
    
}
