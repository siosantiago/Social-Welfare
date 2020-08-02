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
        backgroundColor = .clear
        setTitleColor(#colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1), for: .normal)
        //Cuatro estados del boton: normal, seleccionado, deshabilitar, y remarcado.
        //normal, selected, enable, disable
        setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .highlighted)
        //partes graficas del boton no son atritubos del boton si no del layer.
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 8.0
        titleLabel?.font = .boldSystemFont(ofSize: 20)
    }
    
    
}
