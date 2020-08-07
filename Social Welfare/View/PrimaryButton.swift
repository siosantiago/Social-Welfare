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
        setTitleColor(#colorLiteral(red: 0.9176470588, green: 0.5647058824, blue: 0.4784313725, alpha: 1), for: .normal)
        //Cuatro estados del boton: normal, seleccionado, deshabilitar, y remarcado.
        //normal, selected, enable, disable
        setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .highlighted)
        //partes graficas del boton no son atritubos del boton si no del layer.
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 8.0
        titleLabel?.font = .boldSystemFont(ofSize: 20)
    }
    
    
}
