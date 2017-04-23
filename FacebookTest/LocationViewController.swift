//
//  LocationViewController.swift
//  FacebookTest
//
//  Created by Raj Shah on 4/16/17.
//  Copyright © 2017 Jeffrey Gu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

var ref: FIRDatabaseReference!
var refHandle: UInt!

struct users{
    let name: String!
    let location: String!
}







protocol LocateOnTheMap{
    func locateWithLongitude(_ lon:Double, andLatitude lat:Double, andTitle title: String)
}

class SearchResultsController: UITableViewController {
    
    var userDets = [users]()
    
    
    var searchResults: [String]!
    var delegate: LocateOnTheMap!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchResults = Array()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        
        
        ref = FIRDatabase.database().reference(fromURL: "https://almanaccfb.firebaseio.com/")
        
//        for friend in friendsArray{
//            let idString = String(friend.id!)
//        
//            refHandle = ref.child("users").child(idString).observe(FIRDataEventType.value, with: { (snapshot) in
//                let dataDict = snapshot.value as! NSDictionary
//                let name = dataDict["name"]
//                
//            
//                let location = dataDict["location"]
//                
//                self.userDets.insert(users(name: name as! String!, location: location as! String!), at: 0)
//                
//                
//        
//        
//            })
//            
//            
//            
//            
//        }
        findFriends()
        print("before loop")
        dump(friendsArray)
        
        let newArray = friendsArray
        
        
        
        for friend in newArray{
            print("in loop")
            let idString = String(friend.id!)
            print("this is \(friend.id)")
            
            ref.child("users").child(idString).observeSingleEvent(of: .value, with: {
                (snapshot) in
                
                let dataDict = snapshot.value as! NSDictionary
                
                
                
                
                let name = dataDict["name"]
                
            
            
            })
         
            
        }
        

       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.searchResults.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        
        cell.textLabel?.text = self.searchResults[indexPath.row]
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath){
//        // 1
//        self.dismiss(animated: true, completion: nil)
//        // 2
//        let urlpath = "https://maps.googleapis.com/maps/api/geocode/json?address=\(self.searchResults[indexPath.row])&sensor=false".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        
//        let url = URL(string: urlpath!)
//        // print(url!)
//        let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) -> Void in
//            // 3
//            
//            do {
//                if data != nil{
//                    let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! NSDictionary
//                    
//                    let lat =   (((((dic.value(forKey: "results") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "geometry") as! NSDictionary).value(forKey: "location") as! NSDictionary).value(forKey: "lat")) as! Double
//                    
//                    let lon =   (((((dic.value(forKey: "results") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "geometry") as! NSDictionary).value(forKey: "location") as! NSDictionary).value(forKey: "lng")) as! Double
//                    // 4
//                    self.delegate.locateWithLongitude(lon, andLatitude: lat, andTitle: self.searchResults[indexPath.row])
//                }
//                
//            }catch {
//                print("Error")
//            }
//        }
//        // 5
//        task.resume()
    }
    
    
    func reloadDataWithArray(_ array:[String]){
        self.searchResults = array
        self.tableView.reloadData()
}
}
