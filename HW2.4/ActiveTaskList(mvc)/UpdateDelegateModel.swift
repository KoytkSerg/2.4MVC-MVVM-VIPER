//
//  UpdateDelegateModel.swift
//  HW2.4
//
//  Created by Sergii Kotyk on 6/10/21.
//

import Foundation

protocol UpdateTableDelegate{
    func updateTable()
}

extension ViewController: UpdateTableDelegate{
    
    func reloadTable(){
        realm.resaults = realm.realm.objects(Task.self).filter("status < 2").sorted(byKeyPath: "status")
        if realm.resaults?.isEmpty == true { tabBarItem.isEnabled = false; self.tabBarController?.selectedIndex = 1 } else { tabBarItem.isEnabled = true}
        taskList.reloadData()
    }
    
    func updateTable() {
        reloadTable()
    }
    
}
