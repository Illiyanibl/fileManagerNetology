//
//  UIKitExtension.swift
//  FileManager_BlinovIOS39
//
//  Created by Illya Blinov on 4.02.24.
//
import UIKit
extension UIView{
    static var identifier: String {
        String(describing: self)
    }

    func addSubViews(_ viewList : [UIView]){
        viewList.forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)}
    }
}

extension UIViewController {
     func alertError(description: String, title: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default) { _ in }
        alert.addAction(actionOk)
        present(alert, animated: true)
    }
}

extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}
