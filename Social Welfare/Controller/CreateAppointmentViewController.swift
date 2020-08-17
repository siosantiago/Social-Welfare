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
    let user = Auth.auth().currentUser
    let newAppointmentCollectionName = "Appointment"
    let dictionaryTitleVar = "Title"
    let dictionaryDateVar = "Date"
    let dictionaryTimeVar = "Time"
    let dictionaryInfoVar = "Info"
    let dictionaryUserIDVar = "Student ID"
    
    var pickerViewData: [[String]] = []
    var timeChosen: String?
    var minutesChosen: String? = "00"
    var arr1: [String] = []
    var appValid = false
    var datePicked: Date? = nil
    
    @IBOutlet weak var titleAppointmentTextField: UITextField!
    @IBOutlet weak var timeAppointmentPickerView: UIPickerView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var infoAppointmentTextField: UITextField!
    
    let dateFormatter = DateFormatter()
    
    var defaultDate: String? = "0.0"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeAppointmentPickerView.delegate = self
        timeAppointmentPickerView.dataSource = self
        // Do any additional setup after loading the view.
        createPickerViewData()
        datePickerView.datePickerMode = .date
        datePickerView.minimumDate = Date.init()
    }
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        datePicked = datePickerView.date
        print("Date picked = \(datePicked!)")
    }
    
    @IBAction func createNewAppointmentPressed(_ sender: UIButton) {
        if let title = titleAppointmentTextField.text,
            !title.isEmpty,
            let date = datePicked,
            let time = timeChosen,
            let minutes = minutesChosen,
            let info = infoAppointmentTextField.text,
            let safeUser = user,
            !info.isEmpty   {
            let id = safeUser.uid
            db.collection(newAppointmentCollectionName).document(title).setData( [
                dictionaryTitleVar: title,
                dictionaryDateVar: date,
                dictionaryTimeVar: "\(time)\(minutes)",
                dictionaryInfoVar: info,
                dictionaryUserIDVar: id]) { (error) in
                    if let e = error {
                        self.performSegue(withIdentifier: "creationSuccessfulSegue", sender: self)
                        print(e.localizedDescription)
                        
                    }
                    else {
                        self.appValid = true
                        self.performSegue(withIdentifier: "creationSuccessfulSegue", sender: self)
                    }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
        if segue.identifier == "creationSuccessfulSegue" {
            if let destinationVC = segue.destination as? CreationAppointmentSuccesfullyViewController {
                destinationVC.isAppointValid = appValid
            }
        }
        
    }

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
            let firstArr = pickerViewData[component]
            timeChosen = firstArr[row]
        }
        else{
            let firstArr = pickerViewData[component]
            minutesChosen = firstArr[row]
        }
    }
}

