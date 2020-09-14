//
//  UIViewController+extension.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 12/09/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addDoneButtonDoneForTextField(_ textField: UITextField, selector: Selector? = #selector(dismissKeyboard)) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: 320.0, height: 50.0))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: selector)
        done.tintColor = .blue
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textField.inputAccessoryView = doneToolbar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}
