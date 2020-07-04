//
//  WaetherTableViewCell.swift
//  test
//
//  Created by Tejas Nanavati on 04/07/20.
//  Copyright © 2020 Tejas Nanavati. All rights reserved.
//

import UIKit

class WaetherTableViewCell: UITableViewCell {

    
    @IBOutlet weak var stackView1: UIStackView!

    @IBOutlet weak var stackView2: UIStackView!

    @IBOutlet weak var lblCityName: UILabel!

    @IBOutlet weak var lblWeatherDisc: UILabel!

    @IBOutlet weak var lblWind: UILabel!

    @IBOutlet weak var lblTemp: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
