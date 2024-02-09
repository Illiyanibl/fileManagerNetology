//
//  KeyhainManager.swift
//  FileManager_BlinovIOS39
//
//  Created by Illya Blinov on 9.02.24.
//

import KeychainSwift

protocol KeychainManagerProtocol: AnyObject {
    func setValue(key: String, value: String)
    func getValue(key: String) -> String?
}

final class  KeychainManager: KeychainManagerProtocol {
    static let share: KeychainManager = KeychainManager(keychain: KeychainSwift())
    private let keychain: KeychainSwift
    private init(keychain: KeychainSwift){
        self.keychain = keychain
    }
    func setValue(key: String, value: String){
        print("Сохраняю \(value) по ключу \(key)")
        keychain.set(value, forKey: key)
    }
    func getValue(key: String) -> String?{
        print("Получаю по ключу \(key)")
        return keychain.get(key)
    }
}
