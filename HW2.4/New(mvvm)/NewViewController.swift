//
//  NewViewController.swift
//  HW2.4
//
//  Created by Sergii Kotyk on 28/9/21.
//

import UIKit
import Bond
import ReactiveKit


class NewViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var infoLabel: UILabel!
    
    let viewModel = ViewModel()
    
    func startSetup(){
        nameField.layer.cornerRadius = 10
        descriptionTextView.layer.cornerRadius = 10
        addButton.layer.cornerRadius = 10
        infoLabel.textColor = UIColor.red
        addButton.isEnabled = false
    }
    
    func cleanFields(){
        nameField.text = ""
        descriptionTextView.text = ""
        datePicker.date = Date()
    }
    
    func bind(){
        nameField.reactive.text.ignoreNils()
            .bind(to: viewModel.name)
        descriptionTextView.reactive.text.ignoreNils()
            .bind(to: viewModel.descriptionText)
        addButton.reactive.tap
            .bind(to: viewModel.createTask)
    }
    
    func dateTransfer(){
        viewModel.doneDate.value = datePicker.date
    }
    
    func showResult(){
        infoLabel.text = viewModel.infoLabel.value
        addButton.isEnabled = viewModel.buttonEnebleStatus.value
    }
    
    func updateView(){

        datePicker.reactive.date.observeNext{_ in
            self.dateTransfer()
        }
        
        viewModel.buttonEnebleStatus.observeNext{_ in
            self.showResult()
        }
        
        viewModel.goToMainTaskList.observeNext{_ in
            self.tabBarController?.selectedIndex = 0
        }
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startSetup()
        bind()
        updateView()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cleanFields()
    }
}


