//
//  ProfileViewController.swift
//  FacebookTest
//
//  Created by Jeffrey Gu on 4/9/17.
//  Copyright © 2017 Jeffrey Gu. All rights reserved.
//

import Foundation
import UIKit
import FacebookCore
import FBSDKCoreKit

//http://stackoverflow.com/questions/39325970/how-to-access-profile-picture-with-facebook-api-in-swift-3
//http://stackoverflow.com/questions/39813497/swift-3-display-image-from-url

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileView: UIImageView!
    static let storyboardIdentifier = "ProfileViewController"
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        
        super.viewDidLoad()
        profileView.image = #imageLiteral(resourceName: "mr-incredible")
        getProfilePicture()

    }
    
    func getProfilePicture() {
        let gr2 : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id,picture.width(198).height(198)"])
        gr2.start(completionHandler: { (connection, result2, error) -> Void in
            let data = result2 as! [String : AnyObject]
            let _loggedInUserSettingRecordName = data["id"] as? String // (forKey: "id") as? String
            let profilePictureURLStr = (data["picture"]!["data"]!! as! [String : AnyObject])["url"]
            
            print("got profile picture url: ", profilePictureURLStr ?? "N/A")
            
            if let urlPath = profilePictureURLStr {
            
                // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
                let url = NSURL(string: urlPath as! String)
                let request = URLRequest(url: url as! URL)
                
//                let task = URLSession.shared().dataTask(with: request as URLRequest) {
                
                let downloadPicTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                    // The download has finished.
                    if let e = error {
                        print("Error downloading cat picture: \(e)")
                    } else {
                        // No errors found.
                        // It would be weird if we didn't have a response, so check for that too.
                        if let res = response as? HTTPURLResponse {
                            print("Downloaded profile picture with response code \(res.statusCode)")
                            if let imageData = data {
                                // Finally convert that Data into an image and do what you wish with it.
                                let image = UIImage(data: imageData)
                                // Do something with your image.
                                self.profileView.image = image
                            } else {
                                print("Couldn't get image: Image is nil")
                            }
                        } else {
                            print("Couldn't get response code for some reason")
                        }
                    }
                }
                downloadPicTask.resume()
            }
        /////gr2 completion//////
        })
    }
    
    
}
