//
//    BaseViewController.swift
//  BykeaCaseStudy
//
//  Created by Hafiz Saad on 24/06/2021.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

    var activityView = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BaseViewController: BaseViewModelDelegate {

    func showErrorAlert(message: String) {
        AlertBuilder.failureAlertWithMessage(message: message)
    }

    func showSuccessAlert(message: String) {
        AlertBuilder.successAlertWithMessage(message: message)
    }

    func showPorgress() {
        DispatchQueue.main.async {
            self.activityView.center = self.view.center
            self.activityView.hidesWhenStopped = true
            self.view.addSubview(self.activityView)
            self.activityView.startAnimating()
        }
    }

    func hideProgress() {
        DispatchQueue.main.async {
            self.activityView.stopAnimating()
        }
    }
}
