//
//  ArchiveViewController.swift
//  HW2.4
//
//  Created by Sergii Kotyk on 5/10/21.
//

import UIKit

class ArchiveViewController: UIViewController {

    @IBOutlet weak var archiveTableView: UITableView!
    
    let realm = RealmClass()
    var celInfo = Task()
    
    func reloadTable(){
        realm.resaults = realm.realm.objects(Task.self).filter("status > 1").sorted(byKeyPath: "dateCreate")
        archiveTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadTable()


    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadTable()
    }



}
extension ArchiveViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        realm.resaults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "archiveCell", for: indexPath) as! ArchiveTableViewCell
        let data = realm.resaults![indexPath.row]
        cell.cellIn(data: data)

    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        celInfo = realm.resaults![indexPath.row]
        archiveTableView.deselectRow(at: indexPath, animated: true)
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
                self.realm.realm.delete(data)
            }
            self.reloadTable()
        }
       
        let done = UITableViewRowAction(style: .normal, title: "Востановить") { (action, indexPath) in
            try! self.realm.realm.write{
                data.status = 0
            }
            self.reloadTable()
            self.tabBarController?.selectedIndex = 0
        }
            
        done.backgroundColor = UIColor.blue
        return [delete, done]
    }
    
}
extension ArchiveViewController: UpdateTableDelegate{
    func updateTable() {
        reloadTable()
        self.tabBarController?.selectedIndex = 0
    }
    
}
