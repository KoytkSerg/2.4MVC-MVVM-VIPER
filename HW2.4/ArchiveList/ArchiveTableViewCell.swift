//
//  ArchiveTableViewCell.swift
//  HW2.4
//
//  Created by Sergii Kotyk on 5/10/21.
//

import UIKit

class ArchiveTableViewCell: UITableViewCell {

    @IBOutlet weak var doneDateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    func dateConvert(date: Date) -> String{
        let formater = DateFormatter()
        formater.dateFormat = "dd.MM.yyyy HH:mm"
        return formater.string(from: date)
    }
    
    func cellIn(data: Task){
        
        nameLabel.textColor = UIColor.red
        nameLabel.text = data.name
        doneDateLabel.text = "Выполнить до: \(dateConvert(date: data.dateDone))"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
