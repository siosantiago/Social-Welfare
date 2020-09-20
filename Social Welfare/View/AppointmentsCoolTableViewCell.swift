//
//  AppointmentsCoolTableViewCell.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 17/09/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit

class AppointmentsCoolTableViewCell: UITableViewCell {

    @IBOutlet weak var coloredView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        coloredView.layer.cornerRadius = 10
        coloredView.layer.shadowRadius = 5
        coloredView.clipsToBounds = true
        layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
