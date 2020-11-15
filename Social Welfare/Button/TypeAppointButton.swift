//
//  TypeAppointButton.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 15/11/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit

class TypeAppointButton: UIButton {

    let color = #colorLiteral(red: 0.7560340762, green: 0.8738755584, blue: 0.9632807374, alpha: 1)

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        layer.backgroundColor = color.cgColor
        layer.cornerRadius = 10
        self.imageView?.clipsToBounds = true
    }
    
}
