//
//  KeyhainManager.swift
//  FileManager_BlinovIOS39
//
//  Created by Illya Blinov on 9.02.24.
//

import KeychainSwift

final class  KeychainManager {
    static let share: KeychainManager = KeychainManager(keychain: KeychainSwift())
    private let keychain: KeychainSwift
    private init(keychain: KeychainSwift){
        self.keychain = keychain
    }
    func setValue(key: String, value: String){
        keychain.set(value, forKey: key)
    }
    func getValue(key: String) -> String?{
        return keychain.get(key)
    }
}
