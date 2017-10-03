//
//  FirstViewController.swift
//  Pigeon
//
//  Created by Cristian Saguil on 6/9/17.
//  Copyright © 2017 Cristian Saguil. All rights reserved.
//

import UIKit

class AboutViewController: PigeonViewController {
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textView.isEditable = false
        self.textView.text = "Developed by Cristian Saguil, October 2017 \n\n'Back Filled' Icon from icons8.com \n'Car' Icon from icons8.com \n'Car Filled' Icon from icons8.com \n'Create' Icon from icons8.com \n'Create Filled' Icon from icons8.com \n'Settings' Icon from icons8.com \n'Settings' Filled” Icon from icons8.com"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

