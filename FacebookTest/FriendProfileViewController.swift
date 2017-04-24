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
    let storageRef = FIRStorage.storage().reference()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var almaMaterLabel: UILabel!
    @IBOutlet weak var workplaceLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if friendID != nil {
            let friendData = ref.child("users").child(friendID!)
            friendData.observeSingleEvent(of: .value, with: { (snapshot) in
                if let friendDataDictionary = snapshot.value as? NSDictionary {
                    self.nameLabel.text = friendDataDictionary["name"] as? String
                    self.locationLabel.text = friendDataDictionary["location"] as? String
                    self.almaMaterLabel.text = friendDataDictionary["education"] as? String
                    self.workplaceLabel.text = friendDataDictionary["work"] as? String
                    
                    //profile image
                    if let pictureURL = friendDataDictionary["picture"] as? String {
                        let filePath = "\(self.friendID!)/\("userPhoto")"
                        print(filePath)
                        self.storageRef.child(filePath).data(withMaxSize: 10*1024*1024, completion: { (data, error) in
                            let userPhoto = UIImage(data: data!)
                            self.profileImage.image = userPhoto
                            print("pulled profile pic locally")
                        })
                    }
                } else {
                    self.nameLabel.text = "Error retrieving data!"
                }
                
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
