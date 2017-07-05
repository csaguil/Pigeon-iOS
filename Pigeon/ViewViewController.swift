//
//  ViewViewController.swift
//  Pigeon
//
//  Created by Cristian Saguil on 6/9/17.
//  Copyright © 2017 Cristian Saguil. All rights reserved.
//

import UIKit
import RealmSwift

final class Ride: Object {
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var email: String = ""
    dynamic var phone: String = ""
    dynamic var origin: String = ""
    dynamic var destination: String = ""
    dynamic var date: String = ""
    dynamic var time: String = ""
    dynamic var seats: Int = 0
}

final class Request: Object {
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var email: String = ""
    dynamic var phone: String = ""
    dynamic var origin: String = ""
    dynamic var destination: String = ""
    dynamic var date: String = ""
    dynamic var time: String = ""
}

class ViewViewController: PigeonViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var buttonRides: UIButton!
    @IBOutlet var buttonRequests: UIButton!
    @IBOutlet var tableView: UITableView!
    var selectedRow = 0
    var ridesToggled = true
    
    var notificationToken: NotificationToken!
    var realm: Realm!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Table View Set Up
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = colors.darkGray()
        setupUI()
        setupRealm()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let destinationVC = segue.destination as! ItemDetailViewController
            destinationVC.ride = self.realm.objects(Ride.self)[selectedRow]
        }
    }
    
    func setupUI(){
        self.buttonRides.layer.borderWidth = 1.0
        self.buttonRequests.layer.borderWidth = 1.0
        self.buttonRides.layer.borderColor = colors.lightGray().cgColor
        self.buttonRequests.layer.borderColor = colors.lightGray().cgColor
        
        self.toggleRides(self)
    }
    
    func setupRealm(){
        // Log in existing user with username and password
        let username = "publicUser@mail.com"  // <--- Update this
        let password = "password"  // <--- Update this
        SyncUser.logIn(with: .usernamePassword(username: username, password: password, register: false), server: URL(string: "http://128.199.67.219:9080/")!) { user, error in
            guard let user = user else {
                return
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
                        self.tableView.reloadData()
                        
                        // Notify us when Realm changes
                        self.notificationToken = self.realm.addNotificationBlock { _ in
                            self.tableView.reloadData()
                        }
                    }

                }
            }
        }

    }
    
    // MARK: UITableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.realm != nil{
            if ridesToggled { return self.realm.objects(Ride.self).count }
            else { return self.realm.objects(Request.self).count }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.backgroundColor = colors.darkGray()
        cell.selectionStyle = .none
        if self.realm != nil {
            let originTitle: UILabel = cell.viewWithTag(2001) as! UILabel
            let destTitle: UILabel = cell.viewWithTag(2002) as! UILabel
            let date: UILabel = cell.viewWithTag(1002) as! UILabel
            let time: UILabel = cell.viewWithTag(1003) as! UILabel
            
            if ridesToggled {
                let ride: Ride = self.realm.objects(Ride.self)[indexPath.row]
                originTitle.text = ride.origin
                destTitle.text = ride.destination
                date.text = ride.date
                time.text = ride.time
            } else {
                let request: Request = self.realm.objects(Request.self)[indexPath.row]
                originTitle.text = request.origin
                destTitle.text = request.destination
                date.text = request.date
                time.text = request.time
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        self.performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    // MARK: Functions
    @IBAction func toggleRides(_ sender: Any) {
        ridesToggled = true
        buttonRides.backgroundColor = colors.lightGreen()
        buttonRequests.backgroundColor = UIColor.lightGray
        
        buttonRides.setTitleColor(colors.darkGray(), for: UIControlState.normal)
        buttonRequests.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.tableView.reloadData()
    }
    @IBAction func toggleRequests(_ sender: Any) {
        ridesToggled = false
        buttonRides.backgroundColor = UIColor.lightGray
        buttonRequests.backgroundColor = colors.lightGreen()
        
        buttonRequests.setTitleColor(colors.darkGray(), for: UIControlState.normal)
        buttonRides.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.tableView.reloadData()
    }
    
    @IBAction func unwindToViewRidesRequests(segue: UIStoryboardSegue) {
        
    }

}

