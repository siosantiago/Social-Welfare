//
//  ProfileViewController.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo on 12/9/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var changePictureButton: UIButton!
    @IBOutlet weak var trophiesView: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addTrophyBorderView()
        setImage()
        // Do any additional setup after loading the view.
    }
    
    func addTrophyBorderView() {
        trophiesView.layer.borderWidth = 5
        trophiesView.layer.cornerRadius = 15
        trophiesView.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    }
    
    func setImage() {
        changePictureButton.imageView?.clipsToBounds = true
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
