//
//  TakeoffFactorsTableViewCell.swift
//  Fit2Fly
//
//  Created by Christina Toldbo on 08/08/2018.
//  Copyright © 2018 Christina Toldbo. All rights reserved.
//

import UIKit

class TakeoffFactorsTableViewCell: UITableViewCell {

    @IBOutlet weak var colorSymbol: UIImageView!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var xCoordinateLabel: UILabel!
    @IBOutlet weak var yCoordinateLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
