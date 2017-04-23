//
//  NotifcationsUtils.swift
//  FacebookTest
//
//  Created by Jonathan Shieh on 4/22/17.
//  Copyright © 2017 Jeffrey Gu. All rights reserved.
//

import Foundation
import FacebookCore

var accessToken: String?

////THIS IS SO UNSECURE I KNOW...but it's not like we have server side code where this would normally go
////Think this is fine for class purposes?
//func getAccessToken(_ callback: ((String, String, String) -> Void)?,
//                    _ recipientID: String = "", _ template: String = "", _ href: String = "") {
//    let params = ["fields": ""] as [String : Any]
//    let graphRequest = GraphRequest(
//        graphPath: "/oauth/access_token?client_id=1874429906130762&client_secret=dc7e24458824f22e07ca0de3e733668d&grant_type=client_credentials",
//        parameters: params)
//    graphRequest.start { (urlResponse, requestResult) in
//        switch requestResult {
//        case .failed(let error):
//            print(error)
//        case .success(let graphResponse):
//            if let responseDictionary = graphResponse.dictionaryValue {
//                accessToken = responseDictionary["access_token"] as! String?
//            }
//            if callback != nil {
//                callback!(recipientID, template, href)
//            }
//        }
//    }
//}

//POST /{recipient_userid}/notifications?access_token=... &template=...&href=...

func sendFBNotification(recipientID: String, template: String, href: String) {
    let params = ["fields": ""] as [String : Any]
    let graphPath = "\(recipientID)/notifications?template=\(template)&href=\(href)"
    print("graph path is: \(graphPath)")
    let graphRequest = GraphRequest(
        graphPath: graphPath,
        parameters: params,
        httpMethod: GraphRequestHTTPMethod(rawValue: "POST")!)
    graphRequest.start { (urlResponse, requestResult) in
        switch requestResult {
        case .failed(let error):
            print("ERRORS ARE AMONG US")
            print(error)
        case .success(let graphResponse):
            if let responseDictionary = graphResponse.dictionaryValue {
                print(responseDictionary)
            }
        }
    }
}

//var request = URLRequest(url: URL(string: "http://www.thisismylink.com/postName.php")!)
//request.httpMethod = "POST"
//let postString = "id=13&name=Jack"
//request.httpBody = postString.data(using: .utf8)
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    guard let data = data, error == nil else {                                                 // check for fundamental networking error
//        print("error=\(error)")
//        return
//    }
//    
//    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//        print("statusCode should be 200, but is \(httpStatus.statusCode)")
//        print("response = \(response)")
//    }
//    
//    let responseString = String(data: data, encoding: .utf8)
//    print("responseString = \(responseString)")
//}
//task.resume()
