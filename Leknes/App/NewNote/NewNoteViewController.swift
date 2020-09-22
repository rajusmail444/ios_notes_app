//
//  NewNoteViewController.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 21/9/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import UIKit
import RxSwift

class NewNoteViewController: UIViewController, ViewControllerProtocol,
UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteDetails: UITextView!
    @IBOutlet weak var callToAction: UIButton!
    
    typealias ViewModelT = NewNoteViewModelType
    var viewModel: NewNoteViewModelType!

    private let noteCreationTimeStamp : Int64 = Date().toSeconds()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        self.title = viewModel.formTitle
        self.setupData()
        self.setupView()
        self.setupCallToActionTapped()
        self.callToAction.setTitle(viewModel.callToActionTitle, for: .normal)
        self.navigationController?.navigationBar.topItem?.accessibilityLabel = "back"
    }

    @IBAction func noteTitleChanged(_ sender: UITextField, forEvent event: UIEvent) {
        setupCallToAction()
    }

    private func setupData() {
        if let note = viewModel.noteInfo {
            self.noteTitle.text = note.noteTitle
            self.noteDetails.text = note.noteText
        }
        self.setupCallToAction()
    }

    private func setupView() {
        noteDetails.delegate = self
        noteTitle.delegate = self

        noteTitle.font = AppFonts.boldFont(size: 18)
        noteTitle.placeholder = "notes_title_placeholder".localized()
        noteTitle.textColor = ColorTheme.black

        noteDetails.font = AppFonts.regularFont(size: 18)
        noteDetails.textColor = ColorTheme.black

        noteDetails.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        noteDetails.layer.borderWidth = 1.0
        noteDetails.layer.cornerRadius = 5
        noteDetails.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
    }

    private func setupCallToAction() {
        if noteTitle.text != nil && noteTitle.text != "" {
            callToAction.isEnabled = true
        } else {
            callToAction.isEnabled = false
        }
    }
     private func setupCallToActionTapped() {
        self.callToAction.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                switch self.viewModel.noteType {
                case .AddNote:
                    self.addItem()
                case .EditNote:
                    self.changeItem()
                }
            }).disposed(by: disposeBag)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
        setupCallToAction()
    }

    private func addItem() -> Void {
        let note = NoteDataModel(noteTitle: noteTitle.text!,
                                 noteText: noteDetails.text,
                                 noteTimeStamp: noteCreationTimeStamp)

        self.viewModel.callToActionTapped.onNext(note)
    }

    private func changeItem() -> Void {
        if let noteInfo = self.viewModel.noteInfo, !self.viewModel.isNoteObjectEmpty {
            let note = NoteDataModel(noteId: noteInfo.noteId,
                                     noteTitle: noteTitle.text!,
                                     noteText: noteDetails.text,
                                     noteTimeStamp: noteCreationTimeStamp)
            self.viewModel.callToActionTapped.onNext(note)
        } else {
            let alert = UIAlertController(
                title: "Unexpected error",
                message: "Cannot change the note, unexpected error occurred. Try again later.",
                preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default ) { (_) in self.performSegue(
                                              withIdentifier: "backToMasterView",
                                              sender: self)})
            self.present(alert, animated: true)
        }
    }

}
