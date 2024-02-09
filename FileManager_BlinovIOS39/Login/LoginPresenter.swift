//
//  LoginPresenter.swift
//  FileManager_BlinovIOS39
//
//  Created by Illya Blinov on 8.02.24.
//
import Foundation
protocol LoginPresenterProtocol: AnyObject {
  func  actionView(viewPassword: String)
  func  setupPresenter()
}
@frozen enum LoginViewState{
    case password
    case setPassword
    case noPassword
}

final class LoginPresenter: LoginPresenterProtocol {
    weak var loginView: LoginViewProtocol?
    private var savedPassword: String?
    private var newPassword: String = ""
    private var statePassword: LoginViewState
    
    init(loginView: LoginViewProtocol? = nil, statePassword: LoginViewState = .password  ) {
        self.loginView = loginView
        self.statePassword = statePassword
        }


    func setupPresenter(){
        switch statePassword {
        case .password:
            getPasswor()
        case .noPassword:
            setPassword()
        case .setPassword:
           break
        }
    }

    func actionView(viewPassword: String) {
        switch statePassword {
        case .noPassword:
            if checkPassword(password: viewPassword) {
                confirmPassword(passwor: viewPassword)
            } else { print("Не подходящий пароль")}
        case .password:
            break
        case .setPassword:
            if viewPassword == newPassword {
                setNewPassword(password: newPassword) } else {
                print("Пароли не совпадают")
                setPassword()
            }
        }
    }

    func checkPassword(password: String) -> Bool {
        guard password.count > 3 else { return false}
        return true
    }

    func setNewPassword(password: String){
        print("Успешно устанавливаю новый пароль")
        loginView?.setBattonTitle(title: "Успешно")


    }


    private func getPasswor(){
        statePassword = .password
        if savedPassword == nil { setPassword() }
        else {
            loginView?.setBattonTitle(title: "Введите пароль")
        }
    }
    private func setPassword(){
        statePassword = .noPassword
        newPassword = ""
        loginView?.setBattonTitle(title: "Создать пароль")
    }
    private func confirmPassword(passwor: String){
        statePassword = .setPassword
        newPassword = passwor
        loginView?.setBattonTitle(title: "Повторите пароль")
    }


}
