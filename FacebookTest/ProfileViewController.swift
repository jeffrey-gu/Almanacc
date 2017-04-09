//
//  ProfileViewController.swift
//  FacebookTest
//
//  Created by Jeffrey Gu on 4/9/17.
//  Copyright © 2017 Jeffrey Gu. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileView: UIImageView!
    static let storyboardIdentifier = "ProfileViewController"
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        
        super.viewDidLoad()
        profileView.image = #imageLiteral(resourceName: "mr-incredible")

    }
    
    
}
