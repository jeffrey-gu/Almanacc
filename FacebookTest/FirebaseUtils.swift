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

let storage = FIRStorage.storage()

// Create a storage reference from our storage service
let storageRef = storage.reference()
// Create a child reference
// imagesRef now points to "images"
let imagesRef = storageRef.child("images")

// Child references can also take paths delimited by '/'
// spaceRef now points to "images/space.jpg"
// imagesRef still points to "images"
var spaceRef = storageRef.child("images/space.jpg")

// This is equivalent to creating the full reference
let storagePath = "\(storageRef.bucket)/images/space.jpg"
spaceRef = storage.reference(forURL: storagePath)

