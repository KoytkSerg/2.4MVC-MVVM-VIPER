//
//  InfoPresenter.swift
//  HW2.4
//
//  Created by Sergii Kotyk on 6/10/21.
//

import Foundation

protocol InfoPresenterProtocol: AnyObject{
    
    
    func configureView()
    func doneButtonClicked()
    func deleteButtonClicked()
    func screenTaped()
    func dataTransfer(data: Task)
    
}

class InfoPresenter: InfoPresenterProtocol{
    
    weak var view: InfoViewControllerProtocol!
    var interactor: InfoInteractorProtocol!
    var router: InfoRouterProtocol!

        
        required init(view: InfoViewControllerProtocol) {
            self.view = view
            
        }
    
    
    func configureView() {
        interactor.engineFunc()
        view.setNameLabel(text: interactor.nameText)
        view.setDescLabelLabel(text: interactor.desriptionText)
        view.setDoneDateLabel(text: interactor.doneDateString())
        view.setCreateDateLabel(text: interactor.createDateString())
        view.setViewsRadius(10)
        view.outletSetups(textcolour: interactor.textColour, buttonText: interactor.buttonTitle, backgroundColor: interactor.backgroundColor)
    }
    
    func doneButtonClicked() {
        interactor.changeStatus()
        router.closeCurrentController()
    }
    
    func deleteButtonClicked() {
        interactor.deleteFromRealm()
        router.closeCurrentController()
    }
    
    func screenTaped() {
        router.closeCurrentController()
    }
    
    func dataTransfer(data: Task) {
        interactor.dataSave(data: data)
    }
    


    
}
