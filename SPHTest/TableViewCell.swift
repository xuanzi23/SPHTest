//
//  TableViewCell.swift
//  SPHTest
//
//  Created by YAP HAO XUAN on 04/10/2019.
//  Copyright © 2019 YAP HAO XUAN. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var displayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
