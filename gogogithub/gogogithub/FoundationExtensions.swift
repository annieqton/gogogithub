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
