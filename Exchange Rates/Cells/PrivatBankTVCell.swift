//
//  TableViewCellPrivat.swift
//  Exchange Rates
//
//  Created by Maryna Bereza on 10/21/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//

import UIKit

class PrivatBankTVCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var buyValueLabel: UILabel!
    @IBOutlet weak var saleValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
