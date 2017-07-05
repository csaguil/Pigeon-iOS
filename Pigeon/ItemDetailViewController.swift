//
//  ItemDetailViewController.swift
//  Pigeon
//
//  Created by Cristian Saguil on 6/9/17.
//  Copyright © 2017 Cristian Saguil. All rights reserved.
//

import UIKit
import GoogleMaps

class ItemDetailViewController: PigeonViewController {
    
    var ride: RideListing? = nil
    var request: RequestListing? = nil
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
        let finishButton = self.view.viewWithTag(4001) as! UIButton
        
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
        }
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
    
    @IBAction func finishPressed(_ sender: Any) {
        
    }
}

