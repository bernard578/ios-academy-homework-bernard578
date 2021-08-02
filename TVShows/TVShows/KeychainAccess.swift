//
//  Keychain.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 02.08.2021..
//

import Foundation
import KeychainAccess

final class KeychainAccess {
    
    static let shared = KeychainAccess()
    
    let keychain = Keychain(service: "KeychainAccessService")
    
    private init() {
        
    }
    
    func store(authInfo: AuthInfo) {
        let encoder = PropertyListEncoder()
        if let encoded = try? encoder.encode(authInfo) {
            try? keychain.set(encoded, key: "authInfo")
        }
    }
    
    func retrieve() -> AuthInfo? {
        let decoder = PropertyListDecoder()
        if
            let data = try? keychain.getData("authInfo"),
            let decodedAuthInfo = try? decoder.decode(AuthInfo.self, from: data)
        {   
            return decodedAuthInfo
        } else {
            return nil
        }
    }
}
