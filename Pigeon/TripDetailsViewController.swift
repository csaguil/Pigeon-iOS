//
//  FirstViewController.swift
//  Pigeon
//
//  Created by Cristian Saguil on 6/9/17.
//  Copyright © 2017 Cristian Saguil. All rights reserved.
//

import UIKit

class TripDetailsViewController: PigeonViewController, UIGestureRecognizerDelegate {
    
    var indicator1 = UIView()
    var indicator2 = UIView()
    var originField = UITextField()
    var destField = UITextField()
    
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
        //Define views
        let radioButtonContainer = self.view.viewWithTag(1)!
        let green1 = radioButtonContainer.viewWithTag(1001)!
        let green2 = radioButtonContainer.viewWithTag(1002)!
        self.indicator1 = (green1.viewWithTag(0))!
        self.indicator2 = (green2.viewWithTag(0))!
        self.originField = self.view.viewWithTag(2001) as! UITextField
        self.destField = self.view.viewWithTag(2002) as! UITextField
        
        //Textfield setup
//        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
//        self.originField.leftViewMode = UITextFieldViewMode.always
//        self.destField.leftViewMode = UITextFieldViewMode.always
//        self.originField.leftView = spacerView
//        self.destField.leftView = spacerView

        //Radio button setup
        green1.layer.cornerRadius = 12.0
        green2.layer.cornerRadius = 12.0
        self.indicator1.layer.cornerRadius = 5.0
        self.indicator2.layer.cornerRadius = 5.0
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(TripDetailsViewController.toggleLeavingFrom))
        tap1.delegate = self as UIGestureRecognizerDelegate
        green1.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(TripDetailsViewController.toggleGoingTo))
        tap2.delegate = self as UIGestureRecognizerDelegate
        green2.addGestureRecognizer(tap2)

        toggleLeavingFrom()
    }
    
    
    func toggleLeavingFrom() {
        self.indicator1.isHidden = false
        self.indicator2.isHidden = true
        
        self.originField.text = "Colgate"
        self.destField.text = ""
        self.destField.attributedPlaceholder = NSAttributedString(string: "Destination",
                                                                  attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
    }
    
    func toggleGoingTo() {
        self.indicator1.isHidden = true
        self.indicator2.isHidden = false
        
        self.destField.text = "Colgate"
        self.originField.text = ""
        self.originField.attributedPlaceholder = NSAttributedString(string: "Origin",
                                                                    attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
    }
    
}

