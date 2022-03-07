//
//  TableViewCell.swift
//  ExchangeMoney
//
//  Created by UgurTurkmen on 5.03.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var differenceLabel: UILabel!
    @IBOutlet weak var salesLabel: UILabel!
    @IBOutlet weak var buylabel: UILabel!
    @IBOutlet weak var moneyName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
