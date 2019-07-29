//
//  InfoTableViewController.swift
//  Deals
//
//  Created by admin on 7/28/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class InfoTableViewController: UITableViewController{

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var arrayMeets: [Meets] = []
    var meetArray: Meets? 
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stateCells(index)
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
    
    
    func stateCells(_ index: Int) {

        meetArray = arrayMeets[index]
        
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
         //performSegue(withIdentifier: "showDetailSegue", sender: meetArray!)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "dataEdit" {
                let dvc = segue.destination as! EditTaskTableViewController
                print(index)
                dvc.arrayMeets = arrayMeets
                dvc.index = index
                dvc.boolValue = true
        }
        
        if segue.identifier == "mapSegue" {
            let dvc = segue.destination as! MapViewController
            dvc.meets = meetArray
        }
        
    }
    
    

}
