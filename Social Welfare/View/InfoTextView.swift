//
//  InfoTextView.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 05/09/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit

class InfoTextView: UITextView {

    
    override func draw(_ rect: CGRect) {
        // Drawing code
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.borderWidth = 2.5
    }
    
    
    
    

}

extension PushNotificationsController: UITextViewDelegate {
     func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let count = textView.text.count + (text.count - range.length)
        if count <= 120 {
            self.lblPushText.text = "\(120 - count) \(String.charsLeft)"
        }
        return count <= 120
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == .placeholderPush {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = .placeholderPush
            textView.textColor = UIColor.gray
        }
    }
}
