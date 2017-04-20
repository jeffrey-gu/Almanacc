//
//  InviteFriendsViewController.swift
//  FacebookTest
//
//  Created by Jonathan Shieh on 4/19/17.
//  Copyright © 2017 Jeffrey Gu. All rights reserved.
//

import UIKit
//import FBSDKCoreKit
import FBSDKShareKit
import FacebookCore
import FacebookShare

class InviteFriendsViewController: UIViewController, FBSDKAppInviteDialogDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inviteButton = UIButton(type: UIButtonType.system) as UIButton
        let xPosition:CGFloat = 50
        let yPosition:CGFloat = 100
        let buttonWidth:CGFloat = 150
        let buttonHeight:CGFloat = 45
        
        inviteButton.frame = CGRect(x: xPosition, y: yPosition, width: buttonWidth, height: buttonHeight)
        inviteButton.setTitle("Invite Friends", for: UIControlState.normal)
        inviteButton.tintColor = UIColor.black
        inviteButton.addTarget(self, action: #selector(InviteFriendsViewController.inviteButtonTapped), for: UIControlEvents.touchUpInside)
        self.view.addSubview(inviteButton)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func inviteButtonTapped()
    {
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

