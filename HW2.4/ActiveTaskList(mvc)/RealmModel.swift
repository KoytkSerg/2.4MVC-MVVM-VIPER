//
//  File.swift
//  HW2.4
//
//  Created by Sergii Kotyk on 29/9/21.
//

import Foundation
import RealmSwift

class Task: Object{
    @objc dynamic var name = ""
    @objc dynamic var taskDescription = ""
    @objc dynamic var dateCreate = Date()
    @objc dynamic var dateDone = Date()
    @objc dynamic var status = 0
    
}

class RealmClass{
    let realm = try! Realm()
    var resaults: Results<Task>?
}
