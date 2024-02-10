//
//  UserDefaults.swift
//  FileManager_BlinovIOS39
//
//  Created by Illya Blinov on 10.02.24.
//

import Foundation
final class SettingManager {
    static let share: SettingManager = SettingManager()
    let defaults = UserDefaults.standard
    private init(){}

    func getSortType() -> Int? {
        defaults.integer(forKey: "sortType")
    }
    func setSortType(sortType: Int) {
        defaults.set(sortType, forKey: "sortType")
    }


}
