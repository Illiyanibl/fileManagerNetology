//
//  LoginView.swift
//  FileManager_BlinovIOS39
//
//  Created by Illya Blinov on 4.02.24.
//

import UIKit
protocol LoginViewProtocol: AnyObject {
    func setBattonTitle(title: String)
    var viewNavigationController: UINavigationController? { get }
    func alertError(description: String, title: String)
}

final class LoginView: UIViewController, LoginViewProtocol {
    weak var viewNavigationController: UINavigationController?
    let loginPresenter: LoginPresenterProtocol?

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var passwordText: UITextField = {
        let text = UITextField()
        text.placeholder = "password"
        text.backgroundColor = .systemGray
        text.textColor = .black
        text.autocapitalizationType = .none
        text.indent(size: 16)
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints = false
        text.delegate = self
        text.layer.cornerRadius = 10
        text.layer.masksToBounds = true
        return text
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemFill.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonTouch), for: .touchUpInside)
        return button
    }()

    init(loginPresenter: LoginPresenterProtocol?) {
        self.loginPresenter = loginPresenter
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        loginPresenter?.setupPresenter()
    }

    private func setupView(){
        viewNavigationController = navigationController
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubViews([passwordText,  loginButton])
    }

    internal func setBattonTitle(title: String){
        loginButton.setTitle(title, for: .normal)
    }

    @objc  func loginButtonTouch(){
        let passwordTextField: String = passwordText.text ?? ""
        passwordText.text = ""
        loginPresenter?.actionView(viewPassword: passwordTextField)
    }
}


extension LoginView: UITextFieldDelegate {
    private func setupConstraints(){
   //     let viewHeight = view.bounds.height
        let viewWidth = view.bounds.width
        let textFieldHeight: CGFloat = 40
        let textFieldWidth = viewWidth / 2
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),

            passwordText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            passwordText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 160),
            passwordText.heightAnchor.constraint(equalToConstant: textFieldHeight),
            passwordText.widthAnchor.constraint(equalToConstant: textFieldWidth),

            loginButton.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 12),
            loginButton.heightAnchor.constraint(equalToConstant: textFieldHeight),
            loginButton.widthAnchor.constraint(equalToConstant: textFieldWidth),
            loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentView.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor),
        ])
    }
}
