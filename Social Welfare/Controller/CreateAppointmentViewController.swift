//
//  CreateAppointmentViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 05/08/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import Firebase

class CreateAppointmentViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    let appointmentsPageController = AppoimentsPageController()
    let newAppointmentCollectionName = "Appointment"
    let dictionaryTitleVar = "Title"
    let dictionaryDateVar = "Date"
    let dictionaryTimeVar = "Time"
    let dictionaryInfoVar = "Info"
    
    var pickerViewData: [[String]] = []
    
    
    @IBOutlet weak var titleAppointmentTextField: UITextField!
    @IBOutlet weak var dateAppointmentTextField: UITextField!
    @IBOutlet weak var timeAppointmentTextField: UITextField!
    @IBOutlet weak var infoAppointmentTextField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createNewAppointmentPressed(_ sender: UIButton) {
        if let title = titleAppointmentTextField.text,
            let date = dateAppointmentTextField.text,
            let time = timeAppointmentTextField.text,
            let info = infoAppointmentTextField.text {
            db.collection(newAppointmentCollectionName).addDocument(data: [
                dictionaryTitleVar: title,
                dictionaryDateVar: date,
                dictionaryTimeVar: time,
                dictionaryInfoVar: info]) { (error) in
                    if let e = error {
                        print(e.localizedDescription)
                    }
                    else {
                        print("Succesfully saved data")
                    }
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CreateAppointmentViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func createPickerViewData() {
        var arr1: [String] = []
        for data in 1...24{
            arr1.append("\(data):")
        }
        pickerViewData.append(arr1)
        pickerViewData.append(["00","30"])
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 24
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewData[component][row]
    }
    
    
}
