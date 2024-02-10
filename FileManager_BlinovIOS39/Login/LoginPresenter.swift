//
//  LoginPresenter.swift
//  FileManager_BlinovIOS39
//
//  Created by Illya Blinov on 8.02.24.
//
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
    private var resetPassword: Bool = false

    init(loginView: LoginViewProtocol? = nil,
         statePassword: LoginViewState) {
        self.statePassword = statePassword

        if statePassword == .noPassword { resetPassword = true }
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
            } else { loginView?.alertError(description: "Пароль должен быть не менее 4 символов", title: "Ошибка")}
        case .password:
            guard let savedPassword else { return }
            if savedPassword == viewPassword { autorisation() } else {
                loginView?.alertError(description: "Неверный пароль", title: "Ошибка")
            }
        case .setPassword:
            if viewPassword == newPassword {
                setNewPassword(password: newPassword) } else {
                loginView?.alertError(description: "Пароли не совпадают. Повторите", title: "Ошибка")
                setPassword()
            }
        }
    }

    func checkPassword(password: String) -> Bool {
        guard password.count > 3 else { return false}
        return true
    }

    func setNewPassword(password: String){
        KeychainManager.share.setValue(key: "password", value: password)
        loginView?.setBattonTitle(title: "Успешно")
        statePassword = .password
        if resetPassword { 
            loginView?.dismissResetPassword() } else {
            autorisation() }
    }

    private func getPasswor(){
        statePassword = .password
        savedPassword =  KeychainManager.share.getValue(key: "password")
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
    private func autorisation(){
        let rootView = Builder.buildRoot()
        loginView?.viewNavigationController?.pushViewController(rootView, animated: true)

    }


}
