//
//  InfoInteractor.swift
//  HW2.4
//
//  Created by Sergii Kotyk on 6/10/21.
//

import Foundation
import RealmSwift



protocol InfoInteractorProtocol: AnyObject {
    func dataSave(data: Task)
    
    func changeStatus()
    func deleteFromRealm()
    func doneDateString() -> String
    func createDateString() -> String
    func engineFunc()
    var nameText: String {get set}
    var desriptionText: String {get set}
    var buttonTitle: String {get set}
    var textColour: UIColor {get set}
    var backgroundColor: UIColor {get set}
}

class InfoInteractor: InfoInteractorProtocol{
    
    weak var presenter: InfoPresenterProtocol!
    
    var data = Task()
    var realm = RealmClass()
    
    var nameText = ""
    var desriptionText = ""
    var textColour = UIColor.white
    var buttonTitle = ""
    var backgroundColor = UIColor.white

    required init(presenter: InfoPresenterProtocol) {
        
        self.presenter = presenter
        
        
    }
    
    private func dateConvert(date: Date) -> String{
        let formater = DateFormatter()
        formater.dateFormat = "dd.MM.yyyy HH:mm"
        return formater.string(from: date)
    }
    
    
    func engineFunc(){
        self.nameText = data.name
        self.desriptionText = data.taskDescription
        
        switch data.status{
        case 0:
            self.textColour = UIColor.black
            self.buttonTitle = "Выполнил"
            self.backgroundColor = UIColor.blue
        case 1:
            self.textColour = UIColor.gray
            self.buttonTitle = "Возобновить"
            self.backgroundColor = UIColor.gray
        default:
            self.textColour = UIColor.gray
            self.buttonTitle = "Востановить"
            self.backgroundColor = UIColor.gray
        }
    }
    
    func doneDateString() -> String{
        "Выполнить до \(dateConvert(date: data.dateDone))"
    }
    func createDateString() -> String{
        "Созданна: \(dateConvert(date: data.dateCreate))"
    }
    
    func dataSave(data: Task){
        self.data = data
    }
    
    func changeStatus(){
        try! self.realm.realm.write{
            switch self.data.status{
            case 0: self.data.status = 1
            case 1: self.data.status = 0
            default: self.data.status = 0
            }
            self.realm.realm.add(self.data)
        }
    }
    
    func deleteFromRealm() {
        try! self.realm.realm.write{
            if self.data.status == 2 {
                self.realm.realm.delete(self.data)
            }else{
            self.data.status = 2
                self.realm.realm.add(self.data)
            }
        }
    }
    
 
}
