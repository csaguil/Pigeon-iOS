//
//  ItemDetailViewController.swift
//  Pigeon
//
//  Created by Cristian Saguil on 6/9/17.
//  Copyright © 2017 Cristian Saguil. All rights reserved.
//

import UIKit
import GoogleMaps
import RealmSwift

class ItemDetailViewController: PigeonViewController {
    
    var ride: RideListing? = nil
    var request: RequestListing? = nil
    var isRide = true
    var type = DataType.RideListing
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    //textfields
    var firstNameField = UITextField()
    var lastNameField = UITextField()
    var emailField = UITextField()
    var phoneField = UITextField()
    
    var finishButton = UIButton()
    
    @IBOutlet var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
        //setupMap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI(){
        //Defining views
        let originLabel = self.view.viewWithTag(2001) as! UILabel
        let destinationLabel = self.view.viewWithTag(2002) as! UILabel
        let dateLabel = self.view.viewWithTag(1001) as! UILabel
        let timeLabel = self.view.viewWithTag(1002) as! UILabel
        let seatsLabel = self.view.viewWithTag(3001) as! UILabel
        finishButton = self.view.viewWithTag(5001) as! UIButton
        firstNameField = self.view.viewWithTag(4001) as! UITextField
        lastNameField = self.view.viewWithTag(4002) as! UITextField
        emailField = self.view.viewWithTag(4003) as! UITextField
        phoneField = self.view.viewWithTag(4004) as! UITextField
        
        if ride != nil{
            //setting text
            originLabel.text = self.ride?.origin
            destinationLabel.text = self.ride?.destination
            dateLabel.text = self.ride?.date
            timeLabel.text = self.ride?.time
            if self.ride?.seats == 1 {
                seatsLabel.text = (self.ride?.seats.description)! + " seat available"
            } else {
                seatsLabel.text = (self.ride?.seats.description)! + " seats available"
            }
            finishButton.setTitle("Request Ride", for: UIControlState.normal)
        }
        if request != nil {
            originLabel.text = self.request?.origin
            destinationLabel.text = self.request?.destination
            dateLabel.text = self.request?.date
            timeLabel.text = self.request?.time
            seatsLabel.isHidden = true
            finishButton.setTitle("Accept Request", for: UIControlState.normal)
            isRide = false
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func setupMap() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        self.mapView.camera = camera
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = self.mapView
        
    }
    
    func createRideRequest() -> RideRequest {
        let requestor = RideRequest()
        if firstNameField.text != nil {
            requestor.firstName = firstNameField.text!
        }
        if lastNameField.text != nil {
            requestor.lastName = lastNameField.text!
        }
        if emailField.text != nil {
            requestor.email = emailField.text!
        }
        if phoneField.text != nil {
            requestor.phone = phoneField.text!
        }
        requestor.ride = self.ride!
        return requestor
    }
    
    func createRequestAcceptance() -> RequestAcceptance {
        let acceptor = RequestAcceptance()
        if firstNameField.text != nil {
            acceptor.firstName = firstNameField.text!
        }
        if lastNameField.text != nil {
            acceptor.lastName = lastNameField.text!
        }
        if emailField.text != nil {
            acceptor.email = emailField.text!
        }
        if phoneField.text != nil {
            acceptor.phone = phoneField.text!
        }
        acceptor.request = self.request!
        return acceptor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ThankYouSegue" {
            let destinationVC = segue.destination as! ThankYouViewController
            destinationVC.isRide = self.isRide
        }
    }
    
    func setupActivityIndicator(start: Bool) {
        if start {
            finishButton.isEnabled = false
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            view.addSubview(activityIndicator)
            
            activityIndicator.startAnimating()
        } else {
            finishButton.isEnabled = true
            activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func finishPressed(_ sender: Any) {
        setupActivityIndicator(start: true)
        // Log in existing user with username and password
        let username = "public"
        let password = "public"
        SyncUser.logIn(with: .usernamePassword(username: username, password: password, register: false), server: URL(string: "http://165.227.121.141:9080/")!) { user, error in
            guard let user = user else {
                fatalError(String(describing: error))
            }
            
            DispatchQueue.main.async {
                // Open Realm
                let configuration = Realm.Configuration(
                    syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: "realm://165.227.121.141:9080/~/requests_accepts")!)
                )
                Realm.asyncOpen(configuration: configuration) { realm, error in
                    if let realm = realm {
                        // Realm successfully opened, with all remote data available
                        try! realm.write {
                            if self.isRide {
                                realm.add(self.createRideRequest())
                            } else {
                                realm.add(self.createRequestAcceptance())
                            }
                        }
                        self.setupActivityIndicator(start: false)
                        self.performSegue(withIdentifier: "ThankYouSegue", sender: nil)
                    }
                    
                }
            }
        }
        
    }
}

