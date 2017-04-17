//
//  FirebaseUtils.swift
//  FacebookTest
//
//  Created by Jesse Huang on 4/11/17.
//  Copyright © 2017 Jeffrey Gu. All rights reserved.
//

import Foundation
import UIKit
import FacebookLogin
import FacebookCore
import Firebase

class FirebaseImage{
    var image:UIImage?
    init() {
        // Points to the root reference
        let storageRef = FIRStorage.storage().reference()
        
        // Points to "images"
        let imagesRef = storageRef.child("images")
        
        // Points to "images/space.jpg"
        // Note that you can use variables to create child values
        let fileName = "guts-boat-dark.jpeg"
        let spaceRef = imagesRef.child(fileName)
        
        // File path is "images/space.jpg"
        let path = spaceRef.fullPath;
        
        // File name is "space.jpg"
        let name = spaceRef.name;
        
        // Points to "images"
        let images = spaceRef.parent()

    }
    
    
    
}

