//
//  nbuTVCell.swift
//  Exchange Rates
//
//  Created by Maryna Bereza on 10/22/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//

import UIKit

class NbuTVCell: UITableViewCell {

    @IBOutlet weak var rateNameLabel: UILabel!
    @IBOutlet weak var valueRaleLabel: UILabel!
    @IBOutlet weak var shortNameRateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
