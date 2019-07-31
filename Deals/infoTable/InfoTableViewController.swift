//
//  InfoTableViewController.swift
//  Deals
//
//  Created by admin on 7/28/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class InfoTableViewController: UITableViewController{
    
    //MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateTime: UIDatePicker!
    
    //MARK: Varibales
    
    var arrayMeets: [Meets] = []
    var meetArray: Meets? 
    var index: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stateCells(index!)
        tableView.tableFooterView = UIView()
        resignFirstResponder()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    // MARK: - Table view cells settings
    
    func stateCells(_ index: IndexPath) {
        
        meetArray = arrayMeets[index.row]
        
        titleLabel.text = meetArray?.name
        switch meetArray?.priority {
        case "0":
            priorityLabel.text = "High"
        case "1":
            priorityLabel.text = "Medium"
        case "2":
            priorityLabel.text = "Low"
        default:
            break
        }
        
        descriptionLabel.text = meetArray?.information
        placeLabel.text = meetArray?.place
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "dataEdit" {
            let dvc = segue.destination as! EditTaskTableViewController
            
            dvc.arrayMeets = arrayMeets
            dvc.index = index
            print(index)
            dvc.boolValue = true
        }
        
        if segue.identifier == "mapSegue" {
            let dvc = segue.destination as! MapViewController
            dvc.meets = meetArray
        }
        
    }
    
    
    
}
