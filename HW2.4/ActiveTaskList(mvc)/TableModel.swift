//
//  ExtensionViewController.swift
//  HW2.4
//
//  Created by Sergii Kotyk on 6/10/21.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        realm.resaults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrTaskCell", for: indexPath) as! CurrTaskTableViewCell
        let data = realm.resaults![indexPath.row]
        cell.cellIn(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        celInfo = realm.resaults![indexPath.row]
        taskList.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showInfo", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destenation = segue.destination as? InfoViewController{
            destenation.data = celInfo
            destenation.delegate = self
        }
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let data = self.realm.resaults![indexPath.row]
        var title = ""
        var isComplited = 0
        let delete = UITableViewRowAction(style: .destructive, title: "Удалить") { (action, indexPath) in
            try! self.realm.realm.write{
                data.status = 2
                self.realm.realm.add(data)
            }
            self.reloadTable()
        }
        
        if data.status == 0 {
            title = "Выполнил"
            isComplited = 1
        }else{
            title = "Возобновить"
            isComplited = 0
        }
        
        let done = UITableViewRowAction(style: .normal, title: title) { (action, indexPath) in
            try! self.realm.realm.write{
                data.status = isComplited
                self.realm.realm.add(data)
            }
            self.reloadTable()
        }
            
        done.backgroundColor = UIColor.blue
        return [delete, done]
    }
}
