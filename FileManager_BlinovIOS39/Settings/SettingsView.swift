//
//  SettingsView.swift
//  FileManager_BlinovIOS39
//
//  Created by Illya Blinov on 10.02.24.
//

import UIKit

final class SettingsView: UIViewController, DelegateSettingsView{
    let resetPasswordView = Builder.buildLogin(state: .noPassword)
    private lazy var passwordButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitle("Сбросить пароль", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemFill.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
        return button
    }()
    private lazy var sortOffButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitle("Отключить сортировку", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemFill.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sortOff), for: .touchUpInside)
        return button
    }()
    private lazy var sortUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitle("Сортировать A-z", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemFill.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sortUp), for: .touchUpInside)
        return button
    }()
    private lazy var sortDownButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitle("Сортировать Z-a", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemFill.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sortDown), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    private func setupView(){
        title = "Настройки"
        view.backgroundColor = .white
        view.addSubview(passwordButton)
        view.addSubview(sortOffButton)
        view.addSubview(sortUpButton)
        view.addSubview(sortDownButton)

    }
    func dismissResetPasswordView() {
        resetPasswordView.dismiss(animated: true)
        alertError(description: "Пароль успешно установлен", title: "Успеx")
    }

    @objc private func resetPassword(){
        resetPasswordView.view.backgroundColor = .systemGray6
        resetPasswordView.delegate = self
        navigationController?.present(resetPasswordView, animated: true)
    }
    @objc private func sortOff(){
        SettingManager.share.setSortType(sortType: -1)
    }
    @objc private func sortUp(){
        SettingManager.share.setSortType(sortType: 0)
    }
    @objc private func sortDown(){
        SettingManager.share.setSortType(sortType: 1)
    }


    private func setupConstraints(){
        let buttonHeight: CGFloat = 40
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            passwordButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 36),
            passwordButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            passwordButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
            passwordButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),


            sortOffButton.topAnchor.constraint(equalTo: passwordButton.bottomAnchor, constant: 36),
            sortOffButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            sortOffButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
            sortOffButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),

            sortUpButton.topAnchor.constraint(equalTo: sortOffButton.bottomAnchor, constant: 12),
            sortUpButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            sortUpButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
            sortUpButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),

            sortDownButton.topAnchor.constraint(equalTo: sortUpButton.bottomAnchor, constant: 12),
            sortDownButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            sortDownButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
            sortDownButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
        ])
    }
}
