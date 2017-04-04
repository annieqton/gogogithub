//
//  GitHubAuthController.swift
//  gogogithub
//
//  Created by Annie Ton-Nu on 4/3/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit

class GitHubAuthController: UIViewController {

    
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.getAccessToken() != nil {
            logInButton.isEnabled = false
        }
        
        
    }

    @IBAction func printTokenPressed(_ sender: Any) {
        print("\(String(describing: UserDefaults.standard.getAccessToken()))")
        
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let parameters = ["scope" : "email,user,repo"]

        GitHub.shared.oAuthRequestWith(parameters: parameters)
        
        
    }
    
    func dismissAuthController() {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
}
