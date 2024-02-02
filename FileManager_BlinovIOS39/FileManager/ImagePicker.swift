//
//  ImagePicker.swift
//  FileManager_BlinovIOS39
//
//  Created by Illya Blinov on 2.02.24.
//

import UIKit

protocol ImagePickerProtocol: AnyObject {
    func presentPickerController()
}
final class ImagePicker: NSObject, ImagePickerProtocol{
    weak var view: FileManagerViewProtocol?
    weak var fileManagerService: FileManagerServiceProtocol?
    lazy var imagePickerController: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        return imagePicker
    }()

    init(view: FileManagerViewProtocol? = nil, fileManagerService: FileManagerServiceProtocol? = nil) {
        self.view = view
        self.fileManagerService = fileManagerService
    }
    internal func presentPickerController(){
        view?.present(controller: imagePickerController)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let photo: UIImage = info[.originalImage] as? UIImage ?? UIImage()
        guard let photoData = photo.pngData() else { return }
        fileManagerService?.savePhoto(photoData)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerController.dismiss(animated: true)
    }


}
