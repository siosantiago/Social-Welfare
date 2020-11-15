//
//  PrimaryButton.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 22/07/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit

//class PrimaryButton: UIButton {
//
//
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//        super.draw(rect)
//        backgroundColor = .clear
//        setTitleColor(#colorLiteral(red: 0.03529411765, green: 0.1450980392, blue: 0.1960784314, alpha: 1), for: .normal)
//        //Cuatro estados del boton: normal, seleccionado, deshabilitar, y remarcado.
//        //normal, selected, enable, disable
//        setTitleColor(#colorLiteral(red: 0.1058823529, green: 0.1490196078, blue: 0.1725490196, alpha: 1), for: .highlighted)
//        //partes graficas del boton no son atritubos del boton si no del layer.
//        layer.borderColor = #colorLiteral(red: 0.03529411765, green: 0.1450980392, blue: 0.1960784314, alpha: 1)
//        layer.borderWidth = 8.0
//        titleLabel?.font = .boldSystemFont(ofSize: 20)
//        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        layer.shadowRadius = 5
//
//
//    }
//
//
//}

class PrimaryButton: UIButton {
    
    
    // Create a gradient layer.
    let backgroundColour: UIColor = #colorLiteral(red: 0.6352941176, green: 0.8352941176, blue: 0.9490196078, alpha: 1)
    let textColour: UIColor = #colorLiteral(red: 0.8117647059, green: 1, blue: 0.9960784314, alpha: 1)
     
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.backgroundColor = backgroundColour.cgColor

        layer.shadowRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.cornerRadius = 15
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.5
        self.imageView?.clipsToBounds = true
    }
}

extension UIButton {
    func buttonWasPressed() {
        layer.shadowOpacity = 0
        layer.backgroundColor = #colorLiteral(red: 0.7294117647, green: 0.8745098039, blue: 0.9725490196, alpha: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.layer.shadowOpacity = 0.5
            self.layer.backgroundColor = #colorLiteral(red: 0.1058823529, green: 0.3537126096, blue: 0.565072127, alpha: 1)
            
        }
        
    }
}

