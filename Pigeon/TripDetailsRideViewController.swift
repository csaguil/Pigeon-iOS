//
//  TripDetailsRideViewController.swift
//  Pigeon
//
//  Created by Cristian Saguil on 6/9/17.
//  Copyright © 2017 Cristian Saguil. All rights reserved.
//

import UIKit
import RealmSwift

class TripDetailsRideViewController: PigeonViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    var indicator1 = UIView()
    var indicator2 = UIView()
    var originField = UITextField()
    var destField = UITextField()
    var dateField = UITextField()
    var timeField = UITextField()
    var seatsField = UITextField()
    var objectData = Dictionary<String, String>()
    var notificationToken: NotificationToken!
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupRealm()
        setupUI()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupRealm(){
        // Log in existing user with username and password
        let username = "publicUser@mail.com"  // <--- Update this
        let password = "password"  // <--- Update this
        SyncUser.logIn(with: .usernamePassword(username: username, password: password, register: false), server: URL(string: "http://128.199.67.219:9080/")!) { user, error in
            guard let user = user else {
                fatalError(String(describing: error))
            }
            
            DispatchQueue.main.async {
                // Open Realm
                let configuration = Realm.Configuration(
                    syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: "realm://128.199.67.219:9080/~/ridesharing")!)
                )
                Realm.asyncOpen(configuration: configuration) { realm, error in
                    if let realm = realm {
                        // Realm successfully opened, with all remote data available
                        self.realm = realm
                    }
                    
                }
            }
        }
        
    }
    
    func getKey(string: String) -> String {
        if string == "Origin" {
            return "origin"
        } else if string == "Destination" {
            return "destination"
        } else if string == "Date"{
            return "date"
        } else if string == "Time" {
            return "time"
        } else if string == "Seats Available" {
            return "seats"
        } else {
            return ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.objectData[self.getKey(string: textField.placeholder!)] = textField.text
        print(self.objectData)
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
        self.dateField = self.view.viewWithTag(2003) as! UITextField
        self.timeField = self.view.viewWithTag(2004) as! UITextField
        self.seatsField = self.view.viewWithTag(2005) as! UITextField
        self.originField.delegate = self
        self.destField.delegate = self
        self.dateField.delegate = self
        self.timeField.delegate = self
        self.seatsField.delegate = self
        
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
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(TripDetailsRideViewController.toggleLeavingFrom))
        tap1.delegate = self as UIGestureRecognizerDelegate
        green1.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(TripDetailsRideViewController.toggleGoingTo))
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
        self.objectData["origin"] = "Colgate"
    }
    
    func toggleGoingTo() {
        self.indicator1.isHidden = true
        self.indicator2.isHidden = false
        
        self.destField.text = "Colgate"
        self.originField.text = ""
        self.originField.attributedPlaceholder = NSAttributedString(string: "Origin",
                                                                    attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        
        self.objectData["destination"] = "Colgate"
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func createRideObject() -> Ride {
        let ride = Ride()
        if objectData["firstName"] != nil {
            ride.firstName = objectData["firstName"]!
        }
        if objectData["lastName"] != nil {
            ride.lastName = objectData["lastName"]!
        }
        if objectData["email"] != nil {
            ride.email = objectData["email"]!
        }
        if objectData["phone"] != nil {
            ride.phone = objectData["phone"]!
        }
        if objectData["origin"] != nil {
            ride.origin = objectData["origin"]!
        }
        if objectData["destination"] != nil {
            ride.destination = objectData["destination"]!
        }
        if objectData["date"] != nil {
            ride.date = objectData["date"]!
        }
        if objectData["time"] != nil {
            ride.time = objectData["time"]!
        }

        return ride
    }
    
    @IBAction func listRide(_ sender: Any) {
        try! self.realm.write {
            self.realm.add(self.createRideObject())
        }
    }
    
    
}

