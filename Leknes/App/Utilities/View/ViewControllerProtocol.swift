//
//  ViewControllerProtocol.swift
//  Leknes
//
//  Created by Rajesh Billakanti on 21/9/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import UIKit

public protocol ViewControllerProtocol {
    associatedtype ViewModelT
    var viewModel: ViewModelT! { get set }
}
