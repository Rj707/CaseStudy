//
//    BaseViewModel.swift
//  BykeaCaseStudy
//
//  Created by Hafiz Saad on 24/06/2021.
//

import Foundation
import UIKit

@objc protocol BaseViewModelDelegate: class {
    func showErrorAlert(message: String)
    func showSuccessAlert(message: String)
    func showPorgress()
    func hideProgress()
}

public class BaseViewModel {
    weak var baseDelegate: BaseViewModelDelegate?
}
