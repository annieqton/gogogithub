//
//  FoundationExtensions.swift
//  gogogithub
//
//  Created by Annie Ton-Nu on 4/3/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import Foundation


//MARK: UserDefaults Extension
extension UserDefaults {
    
    func getAccessToken() -> String? {
        guard let token = UserDefaults.standard.string(forKey: "access_token") else { return nil }
        return token
    }

    func save(accessToken: String) -> Bool {
        UserDefaults.standard.set(accessToken, forKey: "access_token")
        return UserDefaults.standard.synchronize()
    }
}

//MARK: Date conversion from string
extension Date {
    
    var shortStyle: String {
//        let shortFormatter.string(from: self)
        return formatterWith(style: .short).string(from: self)
    }

    
    var mediumStyle: String {
        return formatterWith(style: .medium).string(from: self)
    }
    
    var longStyle: String {
        return formatterWith(style: .long).string(from: self)
    }
    
    
    private func formatterWith(style: DateFormatter.Style) -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = style
        return formatter
    }
}


//MARK: String validation
extension String {
   
    func validate() -> Bool {
        let pattern = "[^0-9a-zA-Z_-]"
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let range = NSRange(location: 0, length: self.characters.count)
            let matches = regex.numberOfMatches(in: self, options: .reportCompletion, range: range)
            
            if matches > 0 {  //invalid string if there's any matches in it. see pattern above
                return false
            }
            
            return true  //if regex can be created and matches is 0 or less, return true as string conforms to pattern
        
        } catch {
           return false
        }
        
    }
    
    
}








