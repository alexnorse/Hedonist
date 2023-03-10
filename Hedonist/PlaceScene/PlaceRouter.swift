//
//  PlaceRouter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/28/22.
//

import UIKit
import CallKit
import SafariServices

protocol PlaceRouterProtocol: AnyObject {
    func openSMM(from: Landmark)
    func openCall(from: Landmark)
    func presentFavAlert()
    func close()
}

final class PlaceRouter: PlaceRouterProtocol {
    // MARK: - Variable
    weak var viewController: PlaceVC?
    
    
    // MARK: - Implementation
    func openSMM(from: Landmark) {
        if let instagram = from.url, let url = URL(string: instagram) {
            viewController?.present(SFSafariViewController(url: url), animated: true)
        } else {
            viewController?.presentAlert(title: AlertTitle.error, message: Errors.faillURL)
        }
    }
    
    
    func openCall(from: Landmark) {
        if let number = from.phone?.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "") {
            if let url = NSURL(string: ("tel:" + "+" + number)) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        } else {
            viewController?.presentAlert(title: AlertTitle.error, message: Errors.serverError)
        }
    }
    
    
    func presentFavAlert() {
        viewController?.presentAlert(title: AlertTitle.success, message: Alerts.addedToFavorites)
    }
    
    
    func close() {
        viewController?.dismiss(animated: true)
    }
}
