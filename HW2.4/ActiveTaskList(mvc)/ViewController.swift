//
//  ViewController.swift
//  HW2.4
//
//  Created by Sergii Kotyk on 24/9/21.


//У приложения три экрана:
//добавление задачи,
//список текущих задач,
//список закрытых и удалённых задач.
//Хранение задач осуществляется с помощью базы данных (например, Realm).
//Каждая задача должна содержать как минимум:
//заголовок;
//описание;
//дату создания;
//дедлайн — время, когда задачу нужно завершить;
//статус: создана, завершена или удалена.
//При нажатии на задачу её можно закрыть, удалить или, наоборот, восстановить.
//Каждый из экранов должен быть реализован с помощью одной из трёх архитектур — MVC, MVVM, VIPER.

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var taskList: UITableView!
    
    let realm = RealmClass()
    var celInfo = Task()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        reloadTable()
    }

}


    
    

