//
//  PigeonNavigationController.swift
//  Pigeon
//
//  Created by Cristian Saguil on 6/9/17.
//  Copyright © 2017 Cristian Saguil. All rights reserved.
//

import UIKit

class PigeonNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let colors = PigeonColors()
        self.navigationBar.barTintColor = colors.lightGray()
        self.navigationBar.tintColor = colors.lightGreen()
        
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        self.navigationItem.title = "Pigeon"

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

