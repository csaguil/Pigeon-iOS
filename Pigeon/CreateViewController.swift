//
//  CreateViewController.swift
//  Pigeon
//
//  Created by Cristian Saguil on 6/9/17.
//  Copyright © 2017 Cristian Saguil. All rights reserved.
//

import UIKit

class CreateViewController: PigeonViewController {
    var isRide = true
    var type = DataType.RideListing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showYourDetails" {
            let destinationVC = segue.destination as! YourDetailsViewController
            destinationVC.isRide = self.isRide
        }
    }
    
    @IBAction func newRide(_ sender: Any) {
        isRide = true
        type = DataType.RideListing
        self.performSegue(withIdentifier: "showYourDetails", sender: nil)
    }

    @IBAction func newRequest(_ sender: Any) {
        isRide = false
        type = DataType.RequestListing
        self.performSegue(withIdentifier: "showYourDetails", sender: nil)
    }

}

