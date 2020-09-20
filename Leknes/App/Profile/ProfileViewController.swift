//
//  ProfileViewController.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 19/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController, ViewControllerProtocol {
    @IBOutlet weak var welcome: Welcome!
    @IBOutlet weak var details: UIButton!
    
    private let disposeBag = DisposeBag()
    
    typealias ViewModelT = ProfileViewModelType
    var viewModel: ProfileViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupDetailsButton()
        self.setupWelcome()
        self.setupDetails()
    }
    
    private func setupDetailsButton() {
        self.details.rx.tap
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.detailsButtonTapped.onNext(())
        }.disposed(by: disposeBag)
    }
    
    private func setupWelcome() {
        self.welcome.configure(text: "Welcome to Profile",
                               color: ColorTheme.red)
        self.welcome.accessibilityIdentifier = "welcome_profile"
    }
    
    private func setupDetails() {
        self.details.setTitle("Details", for: .normal)
        self.details.titleLabel?.font = AppFonts.boldFont(size: 24)
        self.details.titleLabel?.textColor = ColorTheme.blue
        self.details.titleLabel?.textAlignment = .center
        self.details.backgroundColor = ColorTheme.white
        self.details.accessibilityIdentifier = "details_profile"
    }
}

