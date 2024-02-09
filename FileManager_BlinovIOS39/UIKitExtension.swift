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

extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}
