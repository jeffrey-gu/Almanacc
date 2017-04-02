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
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends, .publicProfile ])
        loginButton.center = view.center
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
        print("loginButtonDidCompleteLogin")
    }


}

