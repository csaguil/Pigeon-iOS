//
//  FirstViewController.swift
//  Pigeon
//
//  Created by Cristian Saguil on 6/9/17.
//  Copyright © 2017 Cristian Saguil. All rights reserved.
//

import UIKit

class ItemDetailViewController: PigeonViewController {
    
    var ride: Ride? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupData(){
        let originLabel = self.view.viewWithTag(2001) as! UILabel
        let destinationLabel = self.view.viewWithTag(2002) as! UILabel
        let dateLabel = self.view.viewWithTag(1001) as! UILabel
        let timeLabel = self.view.viewWithTag(1002) as! UILabel
        
        if ride != nil{
            originLabel.text = self.ride?.origin
            destinationLabel.text = self.ride?.destination
            dateLabel.text = self.ride?.date
            timeLabel.text = self.ride?.time
        }
    }
    
}

