//
//  LocationViewController.swift
//  
//
//  Created by Raj Shah on 4/9/17.
//
//

import UIKit

class LocationViewController: UIViewController {
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let gpaViewController = GooglePlacesAutocomplete(
            apiKey: "YOUR GOOGLE PLACE API KEY",
            placeType: .Address
        )
        
        gpaViewController.placeDelegate = self
        
        presentViewController(gpaViewController, animated: true, completion: nil)
    }
}

extension LocationViewController: GooglePlacesAutocompleteDelegate {
    func placeSelected(place: Place) {
        println(place.description)
    }
    
    func placeViewClosed() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

