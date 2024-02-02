//
//  FileManagerService.swift
//  FileManager_BlinovIOS39
//
//  Created by Illya Blinov on 1.02.24.
//

import Foundation
protocol FileManagerServiceProtocol: AnyObject{
    var items: [String] { get }
    func addPhoto()
    func savePhoto(_ image: Data)
    func deleteFile(at: Int)
}

final class FileManagerService: FileManagerServiceProtocol {
    weak var view: FileManagerViewProtocol?
    var imagePicker: ImagePickerProtocol?
    private let pathForFolder: String
    var items: [String] {
        (try? FileManager.default.contentsOfDirectory(atPath: pathForFolder)) ?? []
    }

    init(view: FileManagerViewProtocol? = nil, imagePicker: ImagePickerProtocol? = nil) {
        self.view = view
        self.imagePicker = imagePicker
        pathForFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    func addPhoto(){
        imagePicker?.presentPickerController()
    }
    func savePhoto(_ image: Data){
        let url = URL(filePath: pathForFolder + "/" + "image\(items.count).png")
        try? image.write(to: url)
        view?.reloadTable()
    }
    func deleteFile(at: Int){
        let path = pathForFolder + "/" + items[at]
        try? FileManager.default.removeItem(atPath: path)
        view?.reloadTable()
    }

}
