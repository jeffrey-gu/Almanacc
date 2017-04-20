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
import FBSDKShareKit
import Firebase

//http://stackoverflow.com/questions/39325970/how-to-access-profile-picture-with-facebook-api-in-swift-3
//http://stackoverflow.com/questions/39813497/swift-3-display-image-from-url

class ProfileViewController: UIViewController, FBSDKAppInviteDialogDelegate {
    
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var educationField: UITextField!
    @IBOutlet weak var workField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var nameField: UILabel!
    
    @IBOutlet weak var locEditButton: UIButton!
    @IBOutlet weak var uniEditButton: UIButton!
    @IBOutlet weak var jobEditButton: UIButton!
    
    static let storyboardIdentifier = "ProfileViewController"
    
    let storageRef = FIRStorage.storage().reference()
    let ref = FIRDatabase.database().reference(fromURL: "https://almanaccfb.firebaseio.com/")
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        
        super.viewDidLoad()
        profileView.image = #imageLiteral(resourceName: "mr-incredible")    //default
        
        DispatchQueue.main.async {
            self.getProfileInfo()
        }
//        self.getProfilePicture()
    }
    
    @IBAction func editLocation(_ sender: UIButton) {
        let editStatus = !locationField.isUserInteractionEnabled
        locationField.isUserInteractionEnabled = editStatus
        
        if (editStatus) {
            // if enabled
            locEditButton.setImage(#imageLiteral(resourceName: "check-icon"), for: .normal)
            locationField.becomeFirstResponder()
            //TODO: source Google Maps API for location search?
        }
        else {
            locEditButton.setImage(#imageLiteral(resourceName: "pen-icon"), for: .normal)
            self.view.becomeFirstResponder()
            //TODO update DB
        }
    }
    @IBAction func editUniversity(_ sender: UIButton) {
        let editStatus = !educationField.isUserInteractionEnabled
        educationField.isUserInteractionEnabled = editStatus
        
        if (editStatus) {
            // if enabled
            uniEditButton.setImage(#imageLiteral(resourceName: "check-icon"), for: .normal)
            educationField.becomeFirstResponder()
        }
        else {
            uniEditButton.setImage(#imageLiteral(resourceName: "pen-icon"), for: .normal)
            self.view.becomeFirstResponder()
            //TODO update DB
        }
    }
    @IBAction func editJob(_ sender: UIButton) {
        let editStatus = !workField.isUserInteractionEnabled
        workField.isUserInteractionEnabled = editStatus
        
        if (editStatus) {
            // if enabled
            jobEditButton.setImage(#imageLiteral(resourceName: "check-icon"), for: .normal)
            workField.becomeFirstResponder()
        }
        else {
            jobEditButton.setImage(#imageLiteral(resourceName: "pen-icon"), for: .normal)
            self.view.becomeFirstResponder()
            //TODO update DB
        }
    }
    
    @IBAction func inviteFriends(_ sender: UIButton) {
        print("Invite button tapped")
        
        let inviteDialog:FBSDKAppInviteDialog = FBSDKAppInviteDialog()
        if(inviteDialog.canShow()){
            
            let appLinkUrl:NSURL = NSURL(string: "https://fb.me/1886351618271924")!
            //let previewImageUrl:NSURL = NSURL(string: "http://yourwebpage.com/preview-image.png")!
            
            let inviteContent:FBSDKAppInviteContent = FBSDKAppInviteContent()
            inviteContent.appLinkURL = appLinkUrl as URL!
            //inviteContent.appInvitePreviewImageURL = previewImageUrl as URL!
            
            inviteDialog.content = inviteContent
            inviteDialog.delegate = self
            inviteDialog.show()
        }

    }
    
    func getProfilePicture() {
        //TODO: refactor this using the FacebookCore module instead of FBSDK?
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id,picture.width(198).height(198)"])
        graphRequest.start(completionHandler: { (connection, result2, error) -> Void in
            let data = result2 as! [String : AnyObject]
            let _loggedInUserSettingRecordName = data["id"] as? String // (forKey: "id") as? String
            let profilePictureURLStr = (data["picture"]!["data"]!! as! [String : AnyObject])["url"]
            
            print("got profile picture url: ", profilePictureURLStr ?? "N/A")
            
            if let urlPath = profilePictureURLStr {
            
                // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
                let url = NSURL(string: urlPath as! String)
                let request = URLRequest(url: url as! URL)
                
                let downloadPicTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                    // The download has finished.
                    if let e = error {
                        print("Error downloading profile picture: \(e)")
                    } else {
                        // No errors found, check HTTP response
                        if let res = response as? HTTPURLResponse {
                            print("Downloaded profile picture with response code \(res.statusCode)")
                            if let imageData = data {
                                // Convert Data into image and set profile
                                let image = UIImage(data: imageData)
                                self.profileView.image = image
                                self.storeProfilePic()
                            } else {
                                print("Couldn't get image: Image is nil")
                            }
                        } else {
                            print("Couldn't get HTTP response")
                        }
                    }
                }
                downloadPicTask.resume()
            }
        })
    }
    
    func storeProfilePic() {
        let userInfo = UserDefaults.standard.object(forKey: "userInfo") as? [String:Any] ?? [String:Any]()
        let id = userInfo["id"] as! String
        
        // TODO: tinker with compression quality or use png format?
        let imageData = UIImageJPEGRepresentation(self.profileView.image!, 0.9)!
        // set upload path
        let filePath = "\(id)/\("userPhoto")"
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpg"
        
//        let storageRef = FIRStorage.storage().reference()
//        let ref = FIRDatabase.database().reference(fromURL: "https://almanaccfb.firebaseio.com/")
        
        
        self.storageRef.child(filePath).put(imageData, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            else {
                //store download url in DB
                let downloadURL = metaData!.downloadURL()!.absoluteString
                self.ref.child("users").child(id).updateChildValues(["picture": downloadURL])
            }
        }
    }
    
    func queryFB(flag:Bool) {
        if(!flag) {
            print("pulling profile info from Facebook Graph API")
            let params = ["fields":"name,email,education,location,work,hometown"]
            let graphRequest = GraphRequest(graphPath: "me", parameters: params)
            graphRequest.start { (urlResponse, requestResult) in
                switch requestResult {
                case .failed(let error):
                    print(error)
                case .success(let graphResponse):
                    if let responseDictionary = graphResponse.dictionaryValue {
                        dump(responseDictionary)
                        self.nameField.text = responseDictionary["name"] as? String ?? "Mr. Incredible"
                        
                        let id = responseDictionary["id"] as? String ?? "Invalid ID"
                        let educationList = responseDictionary["education"] as? [Any] ?? [Any]()
                        let schoolDict = educationList[educationList.count-1] as? [String:Any] ?? [String:Any]()
                        let detailedSchoolDict = schoolDict["school"] as? [String:Any] ?? [String:Any]()
                        self.educationField.text = detailedSchoolDict["name"] as? String ?? "Superhero University"
                        
                        let locationDict = responseDictionary["location"] as? [String:Any] ?? [String:Any]()
                        self.locationField.text = locationDict["name"] as? String ?? "Cityville"
                        
                        //Insert dictionary into Firebase
                        let ref = FIRDatabase.database().reference(fromURL: "https://almanaccfb.firebaseio.com/")
                        //                    ref.childByAutoId().updateChildValues(responseDictionary, withCompletionBlock: {(err,ref) in
                        //                        if(err != nil){
                        //                            print(err)
                        //                            return
                        //                        }
                        //                    })
//                        ref.child("users").child(id).setValue(responseDictionary)
                        
                        let storageDict:[String:Any] = ["id":id, "name":self.nameField.text, "education": self.educationField.text, "location":self.locationField.text, "work":self.workField.text]
                        ref.child("users").child(id).setValue(storageDict)
                    }
                }
            }
            getProfilePicture()
        }
        else {
            print("already have profile info")
        }
    }
    
    func getProfileInfo() {
        // pull from UserDefaults for Facebook ID, check against Firebase
        // if exists, no need to make a Graph Request
        var existsInDB = false
        let userInfo = UserDefaults.standard.object(forKey: "userInfo") as? [String:Any] ?? [String:Any]()
        if let keyExists = userInfo["id"] {
//            print("indexing Firebase with id: ", keyExists)
//            let ref = FIRDatabase.database().reference(fromURL: "https://almanaccfb.firebaseio.com/")
            self.ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
                let enumerator = snapshot.children
                while let child = enumerator.nextObject() as? FIRDataSnapshot {
                    let childDict = child.value as? [String:Any] ?? [String:Any]()
                    let id = childDict["id"] as? String ?? "??"
                    if(id == keyExists as? String) {
                        existsInDB = true   //mark flag
                        
                        //education
                        self.educationField.text = childDict["education"] as? String
                        
                        //location
                        self.locationField.text = childDict["location"] as? String ?? "Cityville"
                        
                        //name
                        self.nameField.text = childDict["name"] as? String ?? "Mr. Incredible"
                        
                        //profile image
                        if let pictureURL = childDict["picture"] as? String {
                            let filePath = "\(id)/\("userPhoto")"
                            self.storageRef.child(filePath).data(withMaxSize: 10*1024*1024, completion: { (data, error) in
                                if (error != nil) {
                                    print(error ?? "image pull failed")
                                    self.getProfilePicture()
                                }
                                else {
                                    let userPhoto = UIImage(data: data!)
                                    self.profileView.image = userPhoto
                                    print("pulled profile pic locally")
                                }
                            })
                        }
                    }
                }
                self.queryFB(flag: existsInDB)
            })
        }
        else {
            print("id key doesn't exist")
            queryFB(flag: true)
        }
    }
    
    /**
     Sent to the delegate when the app invite completes without error.
     - Parameter appInviteDialog: The FBSDKAppInviteDialog that completed.
     - Parameter results: The results from the dialog.  This may be nil or empty.
     */
    public func appInviteDialog(_ appInviteDialog: FBSDKAppInviteDialog!, didCompleteWithResults results: [AnyHashable : Any]!){
        print("Complete invite without error")
    }
    
    
    /**
     Sent to the delegate when the app invite encounters an error.
     - Parameter appInviteDialog: The FBSDKAppInviteDialog that completed.
     - Parameter error: The error.
     */
    public func appInviteDialog(_ appInviteDialog: FBSDKAppInviteDialog!, didFailWithError error: Error!){
        print("Error in invite \(error)")
    }
}
