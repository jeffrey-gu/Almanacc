//
//  ViewController.swift
//  FacebookTest
//
//  Created by Jeffrey Gu on 4/1/17.
//  Copyright © 2017 Jeffrey Gu. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import Firebase
class ViewController: UIViewController, LoginButtonDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let loginButton = LoginButton(readPermissions: [.publicProfile,.email, .userFriends, .custom("user_education_history"), .custom("user_location"), .custom("user_work_history"), .custom("user_hometown")])
        loginButton.frame = CGRect(x: 20, y: view.frame.height - 190, width: view.frame.width - 40, height: 50)
        loginButton.delegate = self
        view.addSubview(loginButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonClicked() {
        
    }
    
    // delegate methods
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("loginButtonDidLogOut")
    }
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .failed(let error):
            print(error)
        case .cancelled:
            print("Cancelled")
        case .success(let grantedPermissions, let declinedPermissions, let accessToken):
            print("Logged In")
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                // ...
                if let error = error {
                    // ...
                    return
                }
            }
//            facebookLogin()
            
            // push tab view controller
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
//            guard let controller = storyboard?.instantiateViewController(withIdentifier: ProfileViewController.storyboardIdentifier) as? ProfileViewController else { fatalError("Unable to instantiate an ProfileViewController from the storyboard") }
        }
    }

    
    // NOT USED: storing into user defaults
//    func facebookLogin() {
//        if let accessToken = AccessToken.current {
//            print("accessing user info")
//            let params = ["fields":"name,email"]
//            let graphRequest = GraphRequest(graphPath: "me", parameters: params)
//            graphRequest.start { (urlResponse, requestResult) in
//                switch requestResult {
//                case .failed(let error):
//                    print(error)
//                case .success(let graphResponse):
//                    if let responseDictionary = graphResponse.dictionaryValue {
//                        UserDefaults.standard.set(responseDictionary, forKey: "userInfo")
//                    }
//                }
//            }
//        } else {
//            print("failed to access user info")
//        }
//    }

}

