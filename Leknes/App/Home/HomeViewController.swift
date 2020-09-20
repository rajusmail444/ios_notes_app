//
//  HomeViewController.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 16/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, ViewControllerProtocol {
    @IBOutlet weak var welcome: Welcome!
    @IBOutlet weak var details: UIButton!
    
    private let disposeBag = DisposeBag()
    
    typealias ViewModelT = HomeViewModelType
    var viewModel: HomeViewModelType!
    
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
        self.welcome.configure(text: "Welcome_to_Leknes".localized(),
                               color: UIColor.orange)
        self.welcome.accessibilityIdentifier = "welcome_home"
    }
    
    private func setupDetails() {
        self.details.setTitle("Details", for: .normal)
        self.details.titleLabel?.font = AppFonts.boldFont(size: 24)
        self.details.titleLabel?.textColor = ColorTheme.blue
        self.details.titleLabel?.textAlignment = .center
        self.details.backgroundColor = ColorTheme.white
        self.details.accessibilityIdentifier = "details_home"
    }
}
