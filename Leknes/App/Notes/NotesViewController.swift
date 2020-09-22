//
//  NotesViewController.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 21/9/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NotesViewController: UIViewController, ViewControllerProtocol {
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()
    
    typealias ViewModelT = NotesViewModelType
    var viewModel: NotesViewModelType!
    var noteStorage: NoteStorage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.title = viewModel.title
        self.noteStorage = viewModel.noteStorage
        self.tabBarController?.tabBar.isHidden = true
        self.setupBarButtonItems()
        self.initialiseCoreData()
        self.setupTableCellTapped()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupTableViewLoad()
    }

    func setupTableViewLoad() {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private func setupBarButtonItems() {
        navigationItem.leftBarButtonItem = editButtonItem

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(navigateToNewNote))
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "add_note"
    }

    private func initialiseCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            let alert = UIAlertController(
                title: "Could note get app delegate",
                message: "Could note get app delegate, unexpected error occurred. Try again later.",
                preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default))
            self.present(alert, animated: true)

            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        noteStorage.setManagedContext(managedObjectContext: managedContext)
    }

    @objc func navigateToNewNote() {
        self.viewModel.addButtonTapped.onNext(())
    }

    private func setupTableCellTapped() {
        self.tableView.rx.itemSelected
            .subscribe(onNext: {[weak self] index in
            guard let self = self else { return }
                self.viewModel.editButtonTapped
                    .onNext(self.noteStorage.readNote(at: index.row))
            }).disposed(by: disposeBag)
    }
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table View

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteStorage.count()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTitleCell", for: indexPath)
        if let object = noteStorage.readNote(at: indexPath.row) {
            cell.textLabel!.text = object.noteTitle
            cell.textLabel?.font = AppFonts.boldFont(size: 20)
            cell.textLabel?.textColor = ColorTheme.black
            cell.textLabel?.textAlignment = .left
            cell.accessibilityIdentifier = "note_title"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            noteStorage.removeNote(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
