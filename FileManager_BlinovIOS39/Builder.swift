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

    static func buildSettings() -> SettingsView{
        SettingsView()
    }

    static func buildRoot() -> UIViewController{
        let fileManagerView =  buildFileManager()
        let settingsView = buildSettings()
        fileManagerView.tabBarItem = UITabBarItem(title: "Файлы", image: UIImage(named: "folder"), tag: 0)
        settingsView.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(named: "settings"), tag: 1)
        let rootViewController: UIViewController = {
            let tabBarController = UITabBarController()
            tabBarController.tabBar.barStyle = .default
            tabBarController.tabBar.backgroundColor = .systemBackground
            tabBarController.tabBar.tintColor = .magenta
            tabBarController.tabBar.unselectedItemTintColor = .darkGray
            return tabBarController
        }()
        fileManagerView.inviteButtonAction = { button in
            rootViewController.navigationItem.rightBarButtonItem = button
        }
        fileManagerView.removeButtonAction = {
            rootViewController.navigationItem.rightBarButtonItem = nil
        }
        (rootViewController as? UITabBarController)?.viewControllers = [fileManagerView, settingsView]
        rootViewController.tabBarController?.selectedIndex = 0
        return rootViewController
    }
    
    static func buildLogin(state: LoginViewState = .password ) -> LoginView {
        let loginPresenter = LoginPresenter(statePassword: state)
        let loginView = LoginView(loginPresenter: loginPresenter)
        loginPresenter.loginView = loginView
        return loginView
    }
}
