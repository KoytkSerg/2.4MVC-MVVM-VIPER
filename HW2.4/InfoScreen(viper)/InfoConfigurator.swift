//
//  InfoConfigurator.swift
//  HW2.4
//
//  Created by Sergii Kotyk on 6/10/21.
//

import Foundation

protocol InfoConfiguratorProtocol: AnyObject {
    func configure(with viewController: InfoViewController)
}

class InfoConfigurator: InfoConfiguratorProtocol {
    
    func configure(with viewController: InfoViewController) {
        let presenter = InfoPresenter(view: viewController)
        let interactor = InfoInteractor(presenter: presenter)
        let router = InfoRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router

    }
}
