//
//  FeedEvent.swift
//  FacebookTest
//
//  Created by Jeffrey Gu on 4/12/17.
//  Copyright © 2017 Jeffrey Gu. All rights reserved.
//

import Foundation
import UIKit

enum eventType {
    case newJob
    case newLoc
    case newJobLoc
    case newContact
    case moving
    case movingWantRoomie
}

struct FeedEvent {
    var name:String = "Almanacc"
    var id:String?
    
    var location:String?
    var job:String?
    var contact:String?
    var profilePic:UIImage?
    
    var eventDescription:String?
    var event:eventType? {
        didSet {
            switch event! as eventType {
            case .moving:
                if let loc = location {
                    eventDescription = name + " is moving to " + loc + "!"
                }
                else {
                    eventDescription = name + " is moving!"
                }
            case .movingWantRoomie:
                if let loc = location {
                    eventDescription = name + " is moving to " + loc + " and is looking for roommates!"
                }
                else {
                    eventDescription = name + " is moving and is look for roommates!"
                }
            case.newContact:
                if let c = contact {
                    eventDescription = name + " changed contacts to: " + c
                }
                else {
                    eventDescription = name + " changed contact information."
                }
            case.newJob:
                if let j = job {
                    eventDescription = name + " is now working at: " + j
                }
                else {
                    eventDescription = name + " changed jobs."
                }
                
            case.newJobLoc:
                if let j = job {
                    if let loc = location {
                        eventDescription = name + " is now working at: " + j + " in " + loc + "!"
                    }
                }
                else {
                    eventDescription = name + " changed jobs."
                }
            case.newLoc:
                if let loc = location {
                    eventDescription = name + " is currently in " + loc + ". You should meet up!"
                }
            }
        }
    }
    
}
