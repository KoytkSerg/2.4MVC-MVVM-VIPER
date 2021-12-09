//
//  CurrTaskTableViewCell.swift
//  HW2.4
//
//  Created by Sergii Kotyk on 29/9/21.
//

import UIKit

class CurrTaskTableViewCell: UITableViewCell {


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var doneDateLabel: UILabel!
    
    
    
    func dateConvert(date: Date) -> String{
        let formater = DateFormatter()
        formater.dateFormat = "dd.MM.yyyy HH:mm"
        return formater.string(from: date)
    }
    
    func cellIn(data: Task){
        
        switch data.status{
        case 1:
            nameLabel.textColor = UIColor.gray
            self.accessoryType = .checkmark
        default: nameLabel.textColor = UIColor.blue
            self.accessoryType = .none
            
        }
        nameLabel.text = data.name
        doneDateLabel.text = "Выполнить до: \(dateConvert(date: data.dateDone))"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
