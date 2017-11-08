//
//  abcTableViewCell.swift
//  ABCproducts
//
//  Created by Maulana Hasbi on 11/8/17.
//  Copyright © 2017 SMK IDN. All rights reserved.
//

import UIKit

class abcTableViewCell: UITableViewCell {
    @IBOutlet weak var tit: UILabel!
    @IBOutlet weak var no: UILabel!
    @IBOutlet weak var pro: UILabel!
    @IBOutlet weak var mas: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
