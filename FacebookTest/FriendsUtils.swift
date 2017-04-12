//
//  FriendsUtils.swift
//  
//
//  Created by Jonathan Shieh on 4/9/17.
//
//

import Foundation
import FacebookCore

class Friend {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var middleName: String?
    var name: String?
    var email: String?
    var picture: String?
    var location: String?
    var education: String?
    var hometown: String?
    
    init(id: Int, firstName: String, lastName: String, middleName: String, name: String,
        email: String, picture: String, location: String, education: String, hometown: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.middleName = middleName
        self.name = name
        self.email = email
        self.picture = picture
        self.location = location
        self.education = education
        self.hometown = hometown
    }
    
    
}

var friendsArray: [Friend] = []

func findFriends(){
    let params = ["fields": "id, first_name, last_name, middle_name, name, email, picture, location, education, hometown"] as [String : Any]
    let graphRequest = GraphRequest(graphPath: "me/friends", parameters: params)
    graphRequest.start { (urlResponse, requestResult) in
        switch requestResult {
        case .failed(let error):
            print(error)
        case .success(let graphResponse):
            if let responseDictionary = graphResponse.dictionaryValue {
                
                print(responseDictionary)
                print("making it a json?")
                let jsonData = JSON(responseDictionary["data"]!)
                let jsonPaging = JSON(responseDictionary["paging"]!)
                print(jsonData)
                print(jsonPaging)
                
                let picture = jsonData[0]["picture"]["data"]["url"]
                print(picture)
                let name = jsonData[0]["name"]
                print(name)
                let location = jsonData[0]["location"]["name"]
                print(location)
                
                
                
//                friendsArray = responseDictionary["data"] as? [Any]
//                print(friendsArray)
                
                
            }
        }
    }
}

func getFriendLocation(id: String){
    print("what up")
    let params = ["fields": "name, location"]
    let graphRequest = GraphRequest(graphPath: "/" + id, parameters: params)
    graphRequest.start { (urlResponse, requestResult) in
        switch requestResult {
        case .failed(let error):
            print("error")
            print(error)
        case .success(let graphResponse):
            if let responseDictionary = graphResponse.dictionaryValue {
                print(responseDictionary)
                print("here")
                
                //Still haven't implemented pagination
                
            }
        }
    }
}
