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
    @IBOutlet weak var workplaceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if friendID != nil {
            let friendData = ref.child("users").child(friendID!)
            friendData.observeSingleEvent(of: .value, with: { (snapshot) in
                let friendDataDictionary = snapshot.value as! NSDictionary
                self.nameLabel.text = friendDataDictionary["name"] as? String
                self.locationLabel.text = friendDataDictionary["location"] as? String
                self.almaMaterLabel.text = friendDataDictionary["education"] as? String
                self.workplaceLabel.text = friendDataDictionary["work"] as? String
                
            })
            
            
        } else {
            print("friendID was not successfully pushed")
        }
        
    }
    
    @IBAction func pressedViewProfile(_ sender: UIButton) {
        print("url http://facebook.com/\(friendID!)")
        UIApplication.shared.open(URL(string: "http://facebook.com/\(friendID!)")!)
    }

    @IBAction func pressedBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
