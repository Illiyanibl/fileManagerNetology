//
//  FileManagerView.swift
//  FileManager_BlinovIOS39
//
//  Created by Illya Blinov on 1.02.24.
//

import UIKit
protocol FileManagerViewProtocol: AnyObject {
    func present(controller: UIViewController)
    func reloadTable()
    func getItemsList()
}
final class FileManagerView: UIViewController, FileManagerViewProtocol {
    var inviteButtonAction: ((_ button: UIBarButtonItem)-> Void)?
    var removeButtonAction: (()-> Void)?
    let fileManager: FileManagerServiceProtocol
    var itemsList: [String] = []

    lazy var addPhotoButton : UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Добавить фото ...", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addPhoto))
        button.tintColor = .black
        return button
    }()

    lazy var fileTable : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    init(fileManager: FileManagerServiceProtocol) {
        self.fileManager = fileManager
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inviteButtonAction?(addPhotoButton)
        fileManager.getSort()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeButtonAction?()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    func getItemsList(){
        itemsList = fileManager.items
    }

   private func setupView(){
        setupSubView()
        view.backgroundColor = .white
        setupShowingAvatarConstraints(safeArea: self.view.safeAreaLayoutGuide)

        navigationController?.navigationItem.rightBarButtonItem = addPhotoButton
    }

   private func setupSubView(){
        self.navigationItem.rightBarButtonItem = addPhotoButton
        view.addSubview(fileTable)
    }

    @objc func addPhoto(){
        fileManager.addPhoto()

    }
    func present(controller: UIViewController) {
        self.present(controller, animated: true)
    }

    func reloadTable(){
        fileTable.reloadData()
    }

    private func setupShowingAvatarConstraints(safeArea: UILayoutGuide){
        NSLayoutConstraint.activate([
            fileTable.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            fileTable.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            fileTable.topAnchor.constraint(equalTo: safeArea.topAnchor),
            fileTable.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
}

extension FileManagerView : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // fileManager.items.count
        itemsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        var content = cell.defaultContentConfiguration()
        //пробую уменьшить нагрузку - идея не дергать вычислияемый массив в каждом столбце а сохранять актуальный список файлов в массив в FileManagerView
        //  content.text = fileManager.items[indexPath.row]
        content.text = itemsList[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            fileManager.deleteFile(at: indexPath.row)
        case .insert: break
        case .none: break
        @unknown default:
            break
        }
    }
}
