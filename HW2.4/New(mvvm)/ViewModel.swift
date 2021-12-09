//
//  ViewModel.swift
//  HW2.4
//
//  Created by Sergii Kotyk on 5/10/21.
//

import Foundation
import Bond
import ReactiveKit
import SwiftUI

class ViewModel{
    
    let realm = RealmClass()
    
    var doneDate = Property(Date())
    var createTask = Subject<Void, Never>()
    var name = Property("")
    var descriptionText = Property("")
    var infoLabel = Property("")
    
    var validName = Property(false)
    var validDescription = Property(false)
    var validDate = Property(false)
    var validInfo = Property(false)
    var buttonEnebleStatus = Property(false)
    var goToMainTaskList = Property(false)
    
    init() {
        nameValidCheck()
        descriptionValidCheck()
        doneDateValidCheck()
        infoValidCheck()
        fullCheck()
        create()
    }
    
    private func create(){
        createTask.observe{ [unowned self] _ in
            let task = Task()
            try! self.realm.realm.write{
                task.name = self.name.value
                task.dateDone = self.doneDate.value
                task.dateCreate = Date()
                task.taskDescription = self.descriptionText.value
                task.status = 0
                self.realm.realm.add(task)
            }
            self.cleanPropertys()
        }
    }
    
    private func cleanPropertys(){
        self.goToMainTaskList.value = true
        self.descriptionText.value = ""
        self.name.value = ""
        self.doneDate.value = Date()
    }
    
    private func doneDateValidCheck(){
        doneDate.map { $0 > Date() ? true : false}
        .bind(to: validDate)
    }
    
    private func nameValidCheck(){
        name
        .observeNext { [unowned self] text in
            realm.resaults = realm.realm.objects(Task.self)
            if text.count == 0  {
                infoLabel.value = "введите название"
                validName.value = false
            } else {
                validName.value = true
                if validDescription.value == false { infoLabel.value = "введите описание"}
            }
        }
    }
    
    private func descriptionValidCheck(){
        descriptionText
            .observeNext { [unowned self] text in
                if validName.value == true{
                   if text.count == 0 {
                       infoLabel.value = "введите описание"
                    validDescription.value = false
                   } else {
                    validDescription.value = true
                       validDate.value == false ? infoLabel.value = "не корректная дата завершения" : nil
                   }
                }
            }
    }
     
    private func infoValidCheck(){
        validName.combineLatest(with: validDescription)
            .map({ $0 == true && $1 == true ? true : false})
            .bind(to: validInfo)
    }
    
    private func fullCheck(){
        validInfo.combineLatest(with: validDate)
            .map { $0 == true && $1 == true ? true : false}
            .observeNext{ [unowned self] value in
                if value == true {infoLabel.value = ""}
                buttonEnebleStatus.value = value
                print(validInfo.value , validDate.value)
            }
    }
}
