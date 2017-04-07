//
//  RepoDetailController.swift
//  gogogithub
//
//  Created by Annie Ton-Nu on 4/5/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit
import SafariServices

class RepoDetailController: UIViewController {

    var selectedRepo: Repository!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var isForkedLabel: UILabel!
    
    @IBOutlet weak var dateCreatedLabel: UILabel!
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedRepo = selectedRepo {
            self.nameLabel.text = selectedRepo.name
            self.descriptionLabel.text = selectedRepo.description
            self.languageLabel.text = selectedRepo.language
            self.starsLabel.text = "Stars: \(String(describing: selectedRepo.stars))"
            self.isForkedLabel.text = "Fork Status: \(String(describing: selectedRepo.forked))"
            self.dateCreatedLabel.text = "Date Created: \(String(describing: selectedRepo.created))"
//            self.dateCreatedLabel.text = selectedRepo.created.longStyle ?? "Unknown Date"
        }
     
    }
    
    
    @IBAction func moreDetailsPressed(_ sender: Any) {
        guard let selectedRepo = selectedRepo else { return }
        
//        presentWebViewControllerWith(urlString: selectedRepo.repoUrlString)  //webview, no way to dimiss and go back
        presentSafariViewControllerWith(urlString: selectedRepo.repoUrlString)  //safari view
    }
    
    func presentSafariViewControllerWith(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let safariController = SFSafariViewController(url: url)
        self.present(safariController, animated: true, completion: nil)
        
    }
    
    
    func presentWebViewControllerWith(urlString: String) {
        let webController = WebViewController()
        webController.url = urlString
        
        self.present(webController, animated: true, completion: nil)
    }
    
//    @IBAction func donePressed(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//        
//    }
    
    
    
}
