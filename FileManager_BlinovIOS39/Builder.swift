//
//  Builder.swift
//  FileManager_BlinovIOS39
//
//  Created by Illya Blinov on 9.02.24.
//

import UIKit
final class Builder {
    static func buildFileManager() -> FileManagerView {
        let fileManager = FileManagerService()
        let imagePicker = ImagePicker()
        let fileManagerView = FileManagerView(fileManager: fileManager)

        imagePicker.view = fileManagerView
        imagePicker.fileManagerService = fileManager

        fileManager.view = fileManagerView
        fileManager.imagePicker = imagePicker
        return fileManagerView
    }
    static func buildLogin() -> LoginView {
        let loginPresenter = LoginPresenter()
        let loginView = LoginView(loginPresenter: loginPresenter)
        loginPresenter.loginView = loginView
        return loginView
    }

}
