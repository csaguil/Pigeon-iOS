//
//  YourDetailsController.swift
//  Pigeon
//
//  Created by Cristian Saguil on 6/9/17.
//  Copyright © 2017 Cristian Saguil. All rights reserved.
//

import UIKit

class YourDetailsViewController: PigeonViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet var tableView: UITableView!
    let fields = ["First Name", "Last Name", "School Email", "Phone Number", "Class Year"]
    var selected = 0
    var isRide: Bool = true
    var objectData = Dictionary<String, String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = colors.darkGray()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTripDetailsRide" {
            let destinationVC = segue.destination as! TripDetailsRideViewController
            destinationVC.objectData = self.objectData
        }
    }
    
    func getKey(string: String) -> String {
        if string == "First Name" {
            return "firstName"
        } else if string == "Last Name" {
            return "lastName"
        } else if string == "School Email" {
            return "email"
        } else if string == "Phone Number" {
            return "phone"
        } else if string == "Class Year" {
            return "classYear"
        } else {
            return ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.objectData[self.getKey(string: textField.placeholder!)] = textField.text
        print(self.objectData)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "InfoCell")!
        cell.backgroundColor = colors.darkGray()
        
        let textField: UITextField = cell.viewWithTag(1001) as! UITextField
        textField.attributedPlaceholder = NSAttributedString(string: fields[indexPath.row],
                                                             attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = spacerView
        textField.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.resignFirstResponder()
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if isRide {
            self.performSegue(withIdentifier: "showTripDetailsRide", sender: nil)
        }
    }
    
    
    
}

