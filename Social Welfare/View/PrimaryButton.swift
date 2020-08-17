//
//  PrimaryButton.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 22/07/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit

class PrimaryButton: UIButton {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        backgroundColor = .clear
        setTitleColor(#colorLiteral(red: 0.03529411765, green: 0.1450980392, blue: 0.1960784314, alpha: 1), for: .normal)
        //Cuatro estados del boton: normal, seleccionado, deshabilitar, y remarcado.
        //normal, selected, enable, disable
        setTitleColor(#colorLiteral(red: 0.1058823529, green: 0.1490196078, blue: 0.1725490196, alpha: 1), for: .highlighted)
        //partes graficas del boton no son atritubos del boton si no del layer.
        layer.borderColor = #colorLiteral(red: 0.03529411765, green: 0.1450980392, blue: 0.1960784314, alpha: 1)
        layer.borderWidth = 8.0
        titleLabel?.font = .boldSystemFont(ofSize: 20)
    }
    
    
}
