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
    var timeChosen: String?
    var minutesChosen: String?
    var arr1: [String] = []
    
    @IBOutlet weak var titleAppointmentTextField: UITextField!
    @IBOutlet weak var dateAppointmentTextField: UITextField!
    @IBOutlet weak var timeAppointmentPickerView: UIPickerView!
    @IBOutlet weak var infoAppointmentTextField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeAppointmentPickerView.delegate = self
        timeAppointmentPickerView.dataSource = self
        // Do any additional setup after loading the view.
        createPickerViewData()
    }
    
    @IBAction func createNewAppointmentPressed(_ sender: UIButton) {
        if let title = titleAppointmentTextField.text,
            let date = dateAppointmentTextField.text,
            let time = timeChosen,
            let minutes = minutesChosen,
            let info = infoAppointmentTextField.text {
            db.collection(newAppointmentCollectionName).addDocument(data: [
                dictionaryTitleVar: title,
                dictionaryDateVar: date,
                dictionaryTimeVar: "\(time)\(minutes)",
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
        if component == 0{
            return 24
        }
        else{
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            let firstArr = pickerViewData[0]
            timeChosen = firstArr[row]
        }
        else{
            let firstArr = pickerViewData[1]
            minutesChosen = firstArr[row]
        }
        
    }
    
    
}
