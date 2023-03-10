//
//  FavsBuilder.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import UIKit

final class FavsBuilder {
    static func build() -> UIViewController {
        let vc = FavsVC()
        let view = FavsView()
        let interactor = FavsInteractor(dataManager: DataManager())
        let presenter = FavsPresenter()
        let router = FavsRouter()
        
        vc.view = view
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.view = view
        router.viewController = vc
        
        interactor.fetchFavorites()
        
        return vc
    }
}
