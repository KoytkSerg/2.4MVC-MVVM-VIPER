//
//  InfoViewController.swift
//  HW2.4
//
//  Created by Sergii Kotyk on 4/10/21.
//

import UIKit
import Bond

protocol InfoViewControllerProtocol: AnyObject{
    
    func setNameLabel(text: String)
    func setDescLabelLabel(text: String)
    func setCreateDateLabel(text: String)
    func setDoneDateLabel(text: String)
    func setDoneButtonTitle(title: String)
    func setViewsRadius(_ value: CGFloat)
    func outletSetups(textcolour: UIColor, buttonText: String, backgroundColor: UIColor)
    func dataTransfer(data: Task) -> Task
    
    
}

class InfoViewController: UIViewController {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var doneDateLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func doneButtonAction(_ sender: Any) {
        presenter.doneButtonClicked()
        self.delegate?.updateTable()
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        presenter.deleteButtonClicked()
        self.delegate?.updateTable()
    }
    
    var data = Task()
    var delegate: UpdateTableDelegate?
    var presenter: InfoPresenterProtocol!
    let configurator: InfoConfiguratorProtocol = InfoConfigurator()
    

    func dataTransfer(data: Task) -> Task{
        data
    }
    
    func setNameLabel(text: String) {
        nameLabel.text = text
    }
    
    func setDescLabelLabel(text: String){
        descLabel.text = text
    }
    
    func setDoneButtonTitle(title: String){
        doneButton.setTitle(title, for: .normal)
        doneButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    func setCreateDateLabel(text: String){
        createDateLabel.text = text
    }
    
    func setDoneDateLabel(text: String){
        doneDateLabel.text = text
    }
    
    func outletSetups(textcolour: UIColor, buttonText: String, backgroundColor: UIColor){
        nameLabel.textColor = textcolour
        descLabel.textColor = textcolour
        doneButton.setTitle(buttonText, for: .normal)
        doneButton.backgroundColor = backgroundColor
    }
    
    func setViewsRadius(_ value: CGFloat){
        doneButton.layer.cornerRadius = value
        mainView.layer.cornerRadius = value
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        presenter.screenTaped()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.dataTransfer(data: self.data)
        presenter.configureView()
        
    }
}

extension InfoViewController: InfoViewControllerProtocol{
    
}

