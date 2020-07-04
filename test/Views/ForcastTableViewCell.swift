//
//  ForcastTableViewCell.swift
//  test
//
//  Created by Tejas Nanavati on 04/07/20.
//  Copyright © 2020 Tejas Nanavati. All rights reserved.
//

import UIKit

class ForcastTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var stackView1: UIStackView!

    @IBOutlet weak var lblWeatherDisc: UILabel!

    @IBOutlet weak var lblTemp: UILabel!

    
    @IBOutlet weak var lblWind: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
