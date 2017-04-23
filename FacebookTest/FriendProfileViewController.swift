//
//  FriendProfileViewController.swift
//  FacebookTest
//
//  Created by Jonathan Shieh on 4/22/17.
//  Copyright © 2017 Jeffrey Gu. All rights reserved.
//

import UIKit
import Firebase

class FriendProfileViewController: UIViewController {
    
    var friendID: String?
    let ref = FIRDatabase.database().reference(fromURL: "https://almanaccfb.firebaseio.com/")
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var almaMaterLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if friendID != nil {
            let friendData = ref.child("users").child(friendID!)
            print(friendData)
            
            
//            nameLabel.text = friendData
//            locationLabel.text = friendData.value(forKey: "location") as! String
//            almaMaterLabel.text = friendData.value(forKey: "education") as! String
            //todo: add image
            
        } else {
            print("friendID was not successfully pushed")
        }
        
    }
    
    @IBAction func pressedViewProfile(_ sender: UIButton) {
        
    }


}
