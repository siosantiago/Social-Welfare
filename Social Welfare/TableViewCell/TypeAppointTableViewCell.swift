//
//  TypeAppointTableViewCell.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 14/11/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit

class TypeAppointTableViewCell: UITableViewCell {
    
    var delegate:MyCustomCellDelegator!
    
    var typeChosen: AppointmentType?
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func learningSessionTypeButtonPressed(_ sender: Any) {
        typeChosen = .learningSession
        sendSegue()
    }
    
    @IBAction func humanitiesTypeButtonPressed(_ sender: Any) {
        typeChosen = .humaties
        sendSegue()
    }
    
    @IBAction func englishTypeButtonPressed(_ sender: Any) {
        typeChosen = .english
        sendSegue()
    }
    
    @IBAction func mathTypeButtonPressed(_ sender: Any) {
        typeChosen = .math
        sendSegue()
    }
    
    @IBAction func satActTypeButtonPressed(_ sender: Any) {
        typeChosen = .satAct
        sendSegue()
    }
    
    @IBAction func perToPerTypeButtonPressed(_ sender: Any) {
        typeChosen = .personToPerson
        sendSegue()
    }
    
    
    
    func sendSegue() {
        if self.delegate != nil,
           let safeType = typeChosen {
            self.delegate.callSegueFromCell(myData: safeType)
        }
    }
    
}

//Pass any objects, params you need to use on the
//segue call to send to the next controller.

protocol MyCustomCellDelegator {
    func callSegueFromCell(myData dataobject: AppointmentType)
}
