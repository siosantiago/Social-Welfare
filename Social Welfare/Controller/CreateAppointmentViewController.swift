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
    let newAppointmentCollectionName = "appointments"
    let dictionaryTitleVar = "title"
    let dictionaryDateVar = "date"
    let dictionaryTimeVar = "Time"
    let dictionaryInfoVar = "Info"
    let dictionaryUserIDVar = "Student ID"
    let dictionaryAwardHours = "Awarded Hours"
    let defaultText = "input any other information here"
    
    var activeTextField : UITextField? = nil
    
    var arr1: [String] = []
    var appValid = false
    var datePicked: Date? = nil
    var type: AppointmentType? 
    
    @IBOutlet weak var titleAppointmentTextField: UITextField!
    @IBOutlet weak var counterCharLabel: UILabel!
    @IBOutlet weak var timeAppointmentTextField: UITextField!
    @IBOutlet weak var dateAppointmentTextField: UITextField!
    @IBOutlet weak var communityHoursAwardedTextField: UITextField!
    @IBOutlet weak var infoAppointmentTextField: UITextField!
    @IBOutlet weak var infoCounterCharLabel: UILabel!
    @IBOutlet weak var moreInfoScrollView: UITextView!
    @IBOutlet weak var moreInfoCounterLabel: UILabel!
    
    @IBOutlet weak var bottomScrollViewConstraint: NSLayoutConstraint!
    
    let datePickerView = UIDatePicker()
    let timeAppointmentPickerView = UIDatePicker()
    let dateFormatter = DateFormatter()
    
    var defaultDate: String? = "0.0"
    
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(CreateAppointmentViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(CreateAppointmentViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        super.viewDidLoad()
        titleAppointmentTextField.delegate = self
        infoAppointmentTextField.delegate = self
        communityHoursAwardedTextField.delegate = self
        dateAppointmentTextField.delegate = self
        timeAppointmentTextField.inputView = timeAppointmentPickerView
        dateAppointmentTextField.inputView = datePickerView
        // Do any additional setup after loading the view.
        datePickerView.datePickerMode = .date
        datePickerView.minimumDate = Date.init()
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.sizeToFit()
        timeAppointmentPickerView.datePickerMode = .time
        timeAppointmentPickerView.preferredDatePickerStyle = .wheels
        timeAppointmentPickerView.sizeToFit()
        addDoneButtonDoneForTextField(dateAppointmentTextField, selector: #selector(doneDate))
        addDoneButtonDoneForTextField(timeAppointmentTextField, selector: #selector(doneTime))
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        moreInfoScrollView.text = defaultText
        moreInfoScrollView.delegate = self
    }
    
    
    func datePickerChanged() {
        datePicked = datePickerView.date
    }
    
    @IBAction func createNewAppointmentPressed(_ sender: UIButton) {
        if let title = titleAppointmentTextField.text,
            !title.isEmpty,
            let safeDate = datePicked,
            let communityHoursDone = communityHoursAwardedTextField.text,
            let info = infoAppointmentTextField.text,
            let safeType = type,
            let safeUser = user {
            let id = safeUser.uid
            let appointment = Appointment(title: title, date: Timestamp(date: safeDate), info: info, studentID: id, clubMemberID: nil, communityHoursDone: communityHoursDone, moreInfo: moreInfoScrollView.text ?? nil, type: safeType)
            NetworkService.createObject(to: Constants.Collections.appoinment, key: String(Int.random(in: 0...1000000)), object: appointment) { (result) in
                switch result {
                    case .success(_):
                        self.appValid = true
                        self.performSegue(withIdentifier: "creationSuccessfulSegue", sender: self)
                case let .failure(error):
                    print("There was an issue saving data to firestroe, \(error.localizedDescription)")
                }
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

extension CreateAppointmentViewController {
    
    @objc func doneDate() {
        let date = datePickerView.date
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        datePicked = Calendar.current.date(bySetting: .day, value: day, of: datePicked ?? Date())
        datePicked = Calendar.current.date(bySetting: .month, value: month, of: datePicked ?? Date())
        datePicked = Calendar.current.date(bySetting: .year, value: year, of: datePicked ?? Date())

        dateAppointmentTextField.text = date.getSimpleFormat()
        dateAppointmentTextField.resignFirstResponder()
    }
    @objc func doneTime() {
        let date = timeAppointmentPickerView.date
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        datePicked = Calendar.current.date(bySettingHour: hour, minute: minutes, second: 0, of: datePicked ?? Date())

        timeAppointmentTextField.text = date.getTimeFormat()
        timeAppointmentTextField.resignFirstResponder()
    }
    
}

extension CreateAppointmentViewController: UITextFieldDelegate{
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      // set the activeTextField to the selected textfield
        if textField == dateAppointmentTextField {
            datePickerChanged()
        }
        self.activeTextField = textField
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var isTrue = true
        if string == ""{
        }
        else if textField == titleAppointmentTextField || textField == infoAppointmentTextField {
            let count = textField.text?.count ?? 0
            if count <= 20 {
                if textField == titleAppointmentTextField {
                    self.counterCharLabel.text = String(count) + "/25 max"
                }
                else {
                    self.infoCounterCharLabel.text = String(count) + "/25 max"
                }
            }
            isTrue = count <= 20
        }
        else {
            isTrue = true
        }
        return isTrue
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == dateAppointmentTextField {
            datePickerChanged()
        }
        self.activeTextField = nil
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        bottomScrollViewConstraint.constant = keyboardSize.height
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        bottomScrollViewConstraint.constant = 0
    }
      
}



 extension CreateAppointmentViewController: UITextViewDelegate {
      func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
         let count = moreInfoScrollView.text.count + (text.count - range.length)
         if count <= 100 {
            let str = 100 - count
            self.moreInfoCounterLabel.text = String(str) + "/100 max"
         }
         return count <= 100
     }
     
     func textViewDidBeginEditing(_ textView: UITextView) {
        if moreInfoScrollView.text == self.defaultText {
            moreInfoScrollView.text = nil
            moreInfoScrollView.textColor = UIColor.black
         }
     }
     
     func textViewDidEndEditing(_ textView: UITextView) {
         if moreInfoScrollView.text.isEmpty {
            moreInfoScrollView.text = self.defaultText
            moreInfoScrollView.textColor = UIColor.gray
         }
     }
 }
 
