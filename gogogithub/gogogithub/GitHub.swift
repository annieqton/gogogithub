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
typealias FetchReposCompletion = ([Repository]?)->()  //returning () because we use this as a callback


enum GitHubAuthError : Error {
    case extractingCode
}

enum SaveOptions {
    case userDefaults  //identical to local storage, dictionary
}

class GitHub {
    
    private var session: URLSession
    private var components: URLComponents
    
    let gitHubClientID = gHClientID
    let gitHubClientSecret = gHClientSecret
    
    static let shared = GitHub()
    
    
    private init(){  //making our private var a true singleton by private init(){}
        self.session = URLSession(configuration: .default)
        self.components = URLComponents()
        
        self.components.scheme = "https"
        self.components.host = "api.github.com"
        
        if let token = UserDefaults.standard.getAccessToken(){
            let queryItem = URLQueryItem(name: "access_token", value: token)
            self.components.queryItems = [queryItem]
        }
        
    }
    
    func oAuthRequestWith(parameters: [String : String]) {
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
                        
                        let components = dataString.components(separatedBy: "&")
                        
                        print(components)
                        
                        for component in components {
                            if component.contains("access_token"){
                                let access_token = component.components(separatedBy: "=").last
                                complete(success: UserDefaults.standard.save(accessToken: access_token!))
                            }
                        }
                        
                        print("<-----------\(dataString)------------->")
                        
                    } else {
                        complete(success: false)
                    }
                        
                }).resume()  //must resume for dataTask otherwise it would cause bug in production
                
            }
            
        } catch {
            print(error)
            complete(success: false)
        }
    
    }
   
    
    func getRepos(completion: @escaping FetchReposCompletion) {
        
        func returnToMain(results: [Repository]?){  //nested function is private to getRepos function
            OperationQueue.main.addOperation {
                completion(results)
            }
        }
        
        self.components.path = "/user/repos"
        
        guard let url = self.components.url else { returnToMain(results: nil) ; return  }  //if url fails to build, return to main and get out of the scope of this function
        
        self.session.dataTask(with: url) { (data, response, error) in
            if error != nil { returnToMain(results: nil); return }
            
            if let data = data {
                var repositories = [Repository]()
                
                do {
                    if let rootJson = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                      
                        for repositoryJSON in rootJson {
                            if let repo = Repository(json: repositoryJSON){
                                repositories.append(repo)
                            }
                        }
                        returnToMain(results: repositories)
                    }
                    
                    
                } catch {
                    
                }
                
            }
                
        }.resume()
        
    }
    
    
}
