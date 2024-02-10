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
    func getSort()
}

final class FileManagerService: FileManagerServiceProtocol {
    weak var view: FileManagerViewProtocol?
    var imagePicker: ImagePickerProtocol?
    private let pathForFolder: String
    private var sortType: Int?
    var items: [String] {
        let sort: Int = sortType ?? 0
        let itemsNoSort = (try? FileManager.default.contentsOfDirectory(atPath: pathForFolder)) ?? []
        var sortItem: [String] = []
        if sort == -1 { sortItem = itemsNoSort}
        if sort == 0 { sortItem = itemsNoSort.sorted(by: { $0 <  $1 })}
        if sort == 1 { sortItem = itemsNoSort.sorted(by: { $1 <  $0 })}
        return sortItem
    }
    init(view: FileManagerViewProtocol? = nil, imagePicker: ImagePickerProtocol? = nil) {
        self.view = view
        self.imagePicker = imagePicker
        pathForFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    func getSort(){
        sortType = SettingManager.share.getSortType()
        view?.getItemsList()
        view?.reloadTable()
    }
    func addPhoto(){
        imagePicker?.presentPickerController()
    }
    func savePhoto(_ image: Data){
        let url = URL(filePath: pathForFolder + "/" + "image\(items.count).png")
        try? image.write(to: url)
        view?.getItemsList()
        view?.reloadTable()
    }
    func deleteFile(at: Int){
        let path = pathForFolder + "/" + items[at]
        try? FileManager.default.removeItem(atPath: path)
        view?.getItemsList()
        view?.reloadTable()
    }
}
