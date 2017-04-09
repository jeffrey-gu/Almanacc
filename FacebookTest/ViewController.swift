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

class ViewController: UIViewController, LoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let loginButton = LoginButton(readPermissions: [.publicProfile,.email, .userFriends])
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
        }
    }

    func facebookLogin() {
        if let accessToken = AccessToken.current {
            let params = ["fields":"name,email"]
            let graphRequest = GraphRequest(graphPath: "me", parameters: params)
            graphRequest.start { (urlResponse, requestResult) in
                switch requestResult {
                case .failed(let error):
                    print(error)
                case .success(let graphResponse):
                    if let responseDictionary = graphResponse.dictionaryValue {
                        UserDefaults.standard.set(responseDictionary, forKey: "userInfo")
                        
                        
                        guard let view = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {
                            print("Could not push")
                            return
                        }
                        self.navigationController?.pushViewController(view, animated:true)
                        
                        
                    }
                }
            }
        } else {
            print("failed to access user info")
        }
    }

}

