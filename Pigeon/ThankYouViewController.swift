//
//  ThankYouViewController.swift
//  Pigeon
//
//  Created by Cristian Saguil on 6/9/17.
//  Copyright © 2017 Cristian Saguil. All rights reserved.
//

import UIKit

class ThankYouViewController: PigeonViewController {
    
    var message = UILabel()
    var isRide = true
    var type = DataType.RideListing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        message = self.view.viewWithTag(1001) as! UILabel
        
        switch type {
        case .RideListing:
            message.text = "Your Ride Listing is pending approval. Please check back in a few hours to see if your ride was approved"
        
        case .RequestListing:
            message.text = "Your Request Listing is pending approval. Please check back in a few hours to see if your request was approved"
            
        case .RideRequest:
            message.text = "We have received your Ride Request. Please check your email in a few hours for next steps"
            
        case .RequestAcceptance:
            message.text = "We have received your Request Acceptance. Please check your email in a few hours for next steps"
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        //unwinding back to view rides and requests tab
        performSegue(withIdentifier: "unwindSegueToViewRidesRequests", sender: self)
    }
    
}

