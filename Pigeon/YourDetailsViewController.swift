//
//  FirstViewController.swift
//  Pigeon
//
//  Created by Cristian Saguil on 6/9/17.
//  Copyright © 2017 Cristian Saguil. All rights reserved.
//

import UIKit

class YourDetailsViewController: PigeonViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    let fields = ["First Name", "Last Name", "School Email", "Phone Number", "Class Year"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = colors.darkGray()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "InfoCell")!
        cell.backgroundColor = colors.darkGray()
        
        let textField: UITextField = cell.viewWithTag(1001) as! UITextField
        textField.placeholder = fields[indexPath.row]

        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = spacerView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.resignFirstResponder()
    }
    
    
}

