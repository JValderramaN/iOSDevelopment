//
//  ProductCell.swift
//  Shopping Cart
//
//  Created by Office-UpperSky-Hackintosh on 3/11/15.
//  Copyright (c) 2015 UpperSky. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var buttonBuy: UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
