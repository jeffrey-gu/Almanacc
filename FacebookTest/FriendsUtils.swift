//
//  FriendsUtils.swift
//  
//
//  Created by Jonathan Shieh on 4/9/17.
//
//

import Foundation
import FacebookCore

func findFriends(){
    let params = ["fields": "id, first_name, last_name, middle_name, name, email, picture"]
    let graphRequest = GraphRequest(graphPath: "me/taggable_friends", parameters: params)
    graphRequest.start { (urlResponse, requestResult) in
        switch requestResult {
        case .failed(let error):
            print(error)
        case .success(let graphResponse):
            if let responseDictionary = graphResponse.dictionaryValue {
                print(responseDictionary)
            }
        }
    }
}
