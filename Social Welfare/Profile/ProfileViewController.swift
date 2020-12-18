//
//  ProfileViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo on 12/9/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import CodableFirebase
import Firebase

class ProfileViewController: UIViewController {

    //Button Outlets
    @IBOutlet weak var changePictureButton: UIButton!
    @IBOutlet weak var trophiesView: UIView!
    
    //User info outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var joinedDateLabel: UILabel!
    
    //Club info outlets
    @IBOutlet weak var clubOneLabel: UILabel!
    @IBOutlet weak var clubTwoLabel: UILabel!
    @IBOutlet weak var clubThirdLabel: UILabel!
    @IBOutlet weak var etcOrClubFourLabel: UILabel!
    @IBOutlet weak var amountCommunityHoursLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        setInformation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addTrophyBorderView()
        setInformation()
        // Do any additional setup after loading the view.
    }
    
    func addTrophyBorderView() {
        trophiesView.layer.borderWidth = 5
        trophiesView.layer.cornerRadius = 15
        trophiesView.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    }
    
    func setImage(numPic: Int) {
        changePictureButton.imageView?.clipsToBounds = true
        switch numPic {
        case 1:
            self.changePictureButton.setBackgroundImage(#imageLiteral(resourceName: "personOne"), for: .normal)
        case 2:
            self.changePictureButton.setBackgroundImage(#imageLiteral(resourceName: "personTwo"), for: .normal)
        case 3:
            self.changePictureButton.setBackgroundImage(#imageLiteral(resourceName: "personThree"), for: .normal)
        case 4:
            self.changePictureButton.setBackgroundImage(#imageLiteral(resourceName: "personFour"), for: .normal)
        case 5:
            self.changePictureButton.setBackgroundImage(#imageLiteral(resourceName: "personFive"), for: .normal)
        case 6:
            self.changePictureButton.setBackgroundImage(#imageLiteral(resourceName: "personSix"), for: .normal)
        case 7:
            self.changePictureButton.setBackgroundImage(#imageLiteral(resourceName: "personSeven"), for: .normal)
        case 8:
            self.changePictureButton.setBackgroundImage(#imageLiteral(resourceName: "personEight"), for: .normal)
        default:
            self.changePictureButton.setBackgroundImage(#imageLiteral(resourceName: "missingPicture"), for: .normal)
        }
        
    }
    
    func setInformation() {
        if let user = Auth.auth().currentUser {
            let userID = user.uid
            let userInfoRef = "\(Constants.Collections.users)/\(userID)"
            NetworkService.getObject(from: userInfoRef) { (result: ResultRequest<User>) in
                switch result {
                case let .success(objectUser):
                    guard let user = objectUser else { return  }
                    self.nameLabel.text = user.name
                    self.emailLabel.text = user.email
                    self.ageLabel.text = "\(user.age) years old"
                    if let num = user.picture {
                        self.setImage(numPic: num)
                    }
                case .failure(_):
                    print("Couldn't retrieve data")
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
