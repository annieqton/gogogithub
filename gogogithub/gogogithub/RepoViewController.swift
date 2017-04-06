//
//  RepoViewController.swift
//  gogogithub
//
//  Created by Annie Ton-Nu on 4/4/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var repoTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var allRepos = [Repository](){
        didSet {
            repoTableView.reloadData()
        }
    }
    
    
    var displayRepos: [Repository]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.repoTableView.dataSource = self
        self.repoTableView.delegate = self
        self.searchBar.delegate = self
        
        let repoNib = UINib(nibName: "RepoNibCell", bundle: nil)
        
        self.repoTableView.register(repoNib, forCellReuseIdentifier: RepoNibCell.identifier)
        
        self.repoTableView.estimatedRowHeight = 70
        self.repoTableView.rowHeight = UITableViewAutomaticDimension
        
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
    
    
    //    prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == RepoDetailController.identifier {
            segue.destination.transitioningDelegate = self
        }
    }
    
}


//MARK:  extension for segue above
extension RepoViewController : UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CustomTransition(duration: 1.0)
    }
    
}


//MARK:
extension RepoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = repoTableView.dequeueReusableCell(withIdentifier: RepoNibCell.identifier, for: indexPath) as! RepoNibCell

        cell.repoName?.text = displayRepos?[indexPath.row].name ?? allRepos[indexPath.row].name
//        cell.repoDescription?.text = displayRepos?[indexPath.row].description ?? allRepos[indexPath.row].description
//        cell.repoLanguage?.text = displayRepos?[indexPath.row].description ?? allRepos[indexPath.row].language
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayRepos?.count ?? allRepos.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: RepoDetailController.identifier, sender: nil)
    }
    
    
}



//    MARK: UISearchBarDelegate
extension RepoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchedText: String) {
        
        if let searchedText = searchBar.text {
            self.displayRepos = self.allRepos.filter({$0.name.lowercased().contains(searchedText.lowercased())})
        }
        
        if searchBar.text == "" {
            self.displayRepos = nil
        }
        self.repoTableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.displayRepos = nil
        self.searchBar.resignFirstResponder()
    }
    
    
    //    dismiss the keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
}


