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
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var allRepos = [Repository](){
        didSet {
            repoTableView.reloadData()
        }
    }
    
//    TODO:
//    var displayRepos = [Repository]?{
//        didSet{
//            self.repoTableView.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.repoTableView.dataSource = self
        self.repoTableView.delegate = self
        
        update()
        
    }

    func update() {
        print("<--------REPO NAMES--------->")
        GitHub.shared.getRepos { (repositories) in
            //update TableView with the repositories you get back
            if let repositories = repositories {
                self.allRepos = repositories
            }
        }
        
    }
    
}



extension RepoViewController : UITableViewDataSource  {  // add UISearchBarDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.identifier, for: indexPath) as! RepoCell
        
        //TODO: need to refactor this to use for search bar. see note.  cell.textLabel? .text = displayRepos? [indexPath.row].name?? allRepos[indexPath.row].name
        let eachRepo = self.allRepos[indexPath.row]
            cell.eachRepo = eachRepo
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRepos.count  //TODO: need to refactor this to use for search bar. see note.  return displayRepos? count?? allRepos.count
    }
    
    
//    TODO:
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        
//        if let searchedText = searchBar.text {
//            self.displayRepos = self.allRepos.filter({$0.name.contains(searchedText)})
//        }
//        
//        if searchBar.text == "" {
//            self.displayRepos = nil
//        }
//        
//    }
    
    
    
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.displayRepos = nil
//        self.searchBar.resignFirstResponder()
//    }
//    
    
//    dismiss the keyboard
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        self.searchBar.resignFirstResponder()
//    }
    
}
