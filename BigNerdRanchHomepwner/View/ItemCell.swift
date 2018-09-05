//
//  ItemCell.swift
//  BigNerdRanchHomepwner
//
//  Created by 10.12 on 2018/9/5.
//  Copyright © 2018 10.12. All rights reserved.
//

import UIKit
class ItemCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        let caption1Font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
        serialNumberLabel.font = caption1Font
    }
}
