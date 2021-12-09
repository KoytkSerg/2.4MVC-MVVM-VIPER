//
//  InfoRouter.swift
//  HW2.4
//
//  Created by Sergii Kotyk on 6/10/21.
//

import Foundation

protocol InfoRouterProtocol{
    func closeCurrentController()
}

class InfoRouter: InfoRouterProtocol{
    
    
    
    weak var viewController: InfoViewController!
    
    init(viewController: InfoViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentController() {
        viewController.dismiss(animated: true, completion: nil)
    }
   
}
