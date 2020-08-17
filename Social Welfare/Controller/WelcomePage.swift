//
//  WelcomePage.swift
//  Social Welfare
//
//  Created by Santiago Jaramillo Franzoni on 20/07/20.
//  Copyright © 2020 Santiago Jaramillo Franzoni. All rights reserved.
//

import UIKit
import FirebaseAuth

class WelcomePage: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        checkAuth()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func checkAuth(){
        if Auth.auth().currentUser != nil {
          // User is signed in.
          // ...
            goToMain()
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

extension UIViewController {
    func goToMain() {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let appDel: AppDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        let centerVC = mainStoryBoard.instantiateViewController(identifier: "Home")
        appDel.window?.rootViewController = centerVC
        appDel.window?.makeKeyAndVisible()
    }
}
