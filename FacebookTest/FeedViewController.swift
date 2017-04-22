//
//  FeedViewController.swift
//  FacebookTest
//
//  Created by Jeffrey Gu on 4/12/17.
//  Copyright © 2017 Jeffrey Gu. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class FeedViewController: UIViewController,  UITableViewDataSource,UITableViewDelegate {

    
    let ref = FIRDatabase.database().reference(fromURL: "https://almanaccfb.firebaseio.com/")
    var theData = NSMutableArray.init()
        {
        didSet{
            tableView.reloadData()
        }
    }
    var tableView: UITableView!
    
    private func setupTableView() {
        
        tableView = UITableView(frame: view.frame.offsetBy(dx: 0, dy: 50))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
    }
    
    private func fetchDataForTableView() {
        let userInfo = UserDefaults.standard.object(forKey: "userInfo") as? [String:Any] ?? [String:Any]()
        print("foobar")
        print(userInfo["id"])
        if let keyExists = userInfo["id"] {
//            self.ref.child("newsfeed").observeSingleEvent(of: .value, with: { (snapshot) in
//                let enumerator = snapshot.children
//                while let child = enumerator.nextObject() as? FIRDataSnapshot {
//                    let childDict = child.value as? [String:Any] ?? [String:Any]()
//                    dump(childDict)
//                    print("??")
//                    print(childDict)
//                }
//            })
//            print("After query")
            let idString = userInfo["id"] as! String
            print(idString)
            ref.child("newsfeed").child(idString).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                print(snapshot.value)
                
                let newsfeed = snapshot.value as? NSArray
                dump(newsfeed)

                let enumerator = newsfeed?.reverseObjectEnumerator()
                while let status = enumerator?.nextObject() as? NSArray{
                    let date = NSDate(timeIntervalSince1970: status[1] as! TimeInterval)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "M/d/yy, H:mm"
                    let dateString = dateFormatter.string(from: date as Date)
                    let statusTime = [status[0], dateString]
                    self.theData.add(anObject: statusTime)
                    self.tableView.reloadData()
                    print(status[0])
                    print(status[1])
                    print(dateString)
                }
                print("foobar")
                
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
            
            
        }
        else {
            print("id key doesn't exist")
        }

        //********************
    }
    
    private func getJSON(_ url: String) -> JSON {
        
        if let url = URL(string: url){
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                return json
            } else {
                return JSON.null
            }
        } else {
            return JSON.null
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
//        var event = theData["0"]
//        cell.textLabel!.text = event["0"]
//        cell.detailTextLabel?.text = event["1"]
            //print(indexPath.row)
        let event = theData[indexPath.row] as? NSArray
        cell.textLabel!.text = event?[0] as? String
        cell.detailTextLabel!.text = event?[1] as? String
        print(cell.detailTextLabel!.text)
        print(friendsArray)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theData.count
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchDataForTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
}
