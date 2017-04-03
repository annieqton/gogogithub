//
//  GitHub.swift
//  gogogithub
//
//  Created by Annie Ton-Nu on 4/3/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit

let kOAuthBaseURLString = "https://github.com/login/oauth/"

typealias GitHubOAuthCompletion = (Bool)->()

enum GitHubAuthError : Error {
    case extractingCode
}

enum SaveOptions {
    case userDefaults  //identical to local storage, dictionary
}

class GitHub {
    
    let gitHubClientID = "01a91b8c8c6eb1d0dd67"
    let gitHubClientSecret = "61275e02a9e7f4061c9f8677c7131f7ba6e36636"
    
    
    static let shared = GitHub()
    
    func oAuthRequetWith(parameters: [String : String]) {
        var parametersString = ""
        
        for (key, value) in parameters {
            parametersString += "&\(key)=\(value)"
        }
        
        print("Parameters String: \(parametersString)")
        
        if let requestURL = URL(string: "\(kOAuthBaseURLString)authorize?client_id=\(gitHubClientID)\(parametersString)") {
            
            print(requestURL.absoluteString)
            
            UIApplication.shared.open(requestURL)
            
        
        }
    }
    
    func getCodeFrom(url: URL) throws -> String {
        guard let code = url.absoluteString.components(separatedBy: "=").last else {throw GitHubAuthError.extractingCode}
        
        return code
    }
    
    func tokenRequestFor(url: URL, saveOptions: SaveOptions, completion: @escaping GitHubOAuthCompletion){
        
        func complete(success: Bool) {
            OperationQueue.main.addOperation {
                completion(success)
            }
        }
        
        do {
            let code = try getCodeFrom(url: url)
            let requestString = "\(kOAuthBaseURLString)access_token?client_id=\(gitHubClientID)&client_secret=\(gitHubClientSecret)&code=\(code)"
            
            if let requestURL = URL(string: requestString) {
                
                let session = URLSession(configuration: .default)
                
                session.dataTask(with: requestURL, completionHandler: { (data, response, error) in
                    
                    if error != nil { complete(success: false) }
                 
                    guard let data = data else { complete(success: false) ; return }
                    
                    if let dataString = String(data: data, encoding: .utf8){
                        print(dataString)
                    
                        complete(success: true)
                    }
                }).resume()  //must resume for dataTask otherwise it would cause bug in production
                
            }
            
        } catch {
            print(error)
            complete(success: false)
        }
    
    }
    
    
}
