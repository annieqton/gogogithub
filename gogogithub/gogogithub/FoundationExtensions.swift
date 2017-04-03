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

    func save(accesToken: String) -> Bool {
        UserDefaults.standard.set(accesToken, forKey: "access_token")
        return UserDefaults.standard.synchronize()
    }
}
