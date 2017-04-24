//
//  FriendsUtils.swift
//  
//
//  Created by Jonathan Shieh on 4/9/17.
//
//

import Foundation
import FacebookCore

class Friend : CustomStringConvertible {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var middleName: String?
    var name: String?
    var email: String?
    var picture: String?
    var location: String?
    var education: JSON?
    var hometown: String?
    public var description: String { return "Friend: \(name)" }
    
    init(id: Int?, firstName: String?, lastName: String?, middleName: String?, name: String?,
        email: String?, picture: String?, location: String?, education: JSON?, hometown: String?) {
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

//Global Variable - access friends array anywhere
var friendsArray: [Friend] = []


//fill the friends array
func findFriends(){
    let params = ["fields": "id, first_name, last_name, middle_name, name, email, picture, location, education, hometown"] as [String : Any]
    let graphRequest = GraphRequest(graphPath: "me/friends", parameters: params)
    graphRequest.start { (urlResponse, requestResult) in
        switch requestResult {
        case .failed(let error):
            print(error)
        case .success(let graphResponse):
            if let responseDictionary = graphResponse.dictionaryValue {
                
                let jsonData = JSON(responseDictionary["data"]!)
                let jsonPaging = JSON(responseDictionary["paging"]!)
                print(jsonData)
                
                for i in 0...jsonData.count-1 {
                    let picture: String? = jsonData[i]["picture"]["data"]["url"].string
                    let name: String? = jsonData[i]["name"].string
                    let location: String? = jsonData[i]["location"]["name"].string
                    let lastName: String? = jsonData[i]["last_name"].string
                    let middleName: String? = jsonData[i]["middle_name"].string
                    let id = Int(jsonData[i]["id"].string!)
                    let firstName: String? = jsonData[i]["first_name"].string
                    let education: JSON? = jsonData[i]["education"]
                    let hometown: String? = jsonData[i]["hometown"]["name"].string
                    let email: String? = jsonData[i]["email"].string
                    friendsArray.append(Friend(id: id!, firstName: firstName, lastName: lastName, middleName: middleName, name: name, email: email, picture: picture, location: location, education: education, hometown: hometown))
                    
                    
                    
                    
                }
            }
        }
    }
}

