//
//  AppointmentsViewCell.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 27/07/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit

class AppointmentsViewCell: UITableViewCell {
    
    @IBOutlet weak var tittleViewCell: UILabel!
    @IBOutlet weak var infoViewCell: UILabel!
    @IBOutlet weak var dateViewCell: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
