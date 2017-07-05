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
        if isRide {
            message.text = "Your ride listing is pending approval. Please check back in a few hours to see if your ride was approved"
        } else {
            message.text = "Your request for a ride is pending approval. Please check back in a few hours to see if your request was approved"
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToViewRidesRequests", sender: self)
    }
    
}

