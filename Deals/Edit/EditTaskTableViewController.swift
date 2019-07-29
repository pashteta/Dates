//
//  EditTaskTableViewController.swift
//  Deals
//
//  Created by admin on 7/28/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import CoreData

class EditTaskTableViewController: UITableViewController,NSFetchedResultsControllerDelegate {

    @IBOutlet weak var titileTextEdit: UITextField!
    @IBOutlet weak var textFieldDescription: UITextField!
    @IBOutlet weak var placeTextEdit: UITextField!
    
    @IBOutlet weak var choiceButton1: UIButton!
    @IBOutlet weak var choiceButton2: UIButton!
    @IBOutlet weak var choiceButton3: UIButton!
    
    var fetchResultsController: NSFetchedResultsController<Meets>!
    var arrayMeets: [Meets] = []
    var meetArray: Meets?
    var index = 0
    var boolValue: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        if let b = boolValue {
            stateCells(index)
        }
        
    }
    
    func stateCells(_ index: Int) {
        print(index)
        meetArray = arrayMeets[index]
        
        titileTextEdit.text = meetArray?.name
        switch meetArray?.priority {
        case "0":
            choiceButton1.backgroundColor = UIColor.red
        case "1":
             choiceButton2.backgroundColor = UIColor.red
        case "2":
            choiceButton3.backgroundColor = UIColor.red
        default:3
            break
        }
        
        textFieldDescription.text = meetArray?.information
        placeTextEdit.text = meetArray?.place
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        if titileTextEdit.text == "" || textFieldDescription.text == "" || placeTextEdit.text == ""  {
            
            let acb = UIAlertController(title: "Info", message: "Заполнены не все поля" , preferredStyle: .alert)
            let acbAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            acb.addAction(acbAction)
            self.present(acb,animated: true, completion: nil)
            
        } else {
            
            if boolValue != nil {
                arrayMeets.remove(at: index)
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let valuForObject:IndexPath = IndexPath(index: index)
                let objectToDelete = fetchResultsController.object(at:valuForObject)
                context.delete(objectToDelete)
            }
            
            let arrButtons = [choiceButton1,choiceButton2,choiceButton3]
            let arrFields = [titileTextEdit,textFieldDescription,placeTextEdit]
            let dataSave = DataGet()
            dataSave.getValue(arrButtons as! [UIButton],arrFields as! [UITextField])
   
            dismiss(animated: true, completion: nil)
        }
    }
   
    @IBAction func isSelected(_ sender: Any) {
        
        let sender = sender as! UIButton
        switch sender {
        case choiceButton1:
            sender.backgroundColor = UIColor.red
            choiceButton2.backgroundColor = UIColor.green
            choiceButton3.backgroundColor = UIColor.green
        case choiceButton2:
            sender.backgroundColor = UIColor.red
            choiceButton1.backgroundColor = UIColor.green
            choiceButton3.backgroundColor = UIColor.green
        case choiceButton3:
            sender.backgroundColor = UIColor.red
            choiceButton1.backgroundColor = UIColor.green
            choiceButton2.backgroundColor = UIColor.green
        default:
            return
        }
        
    }
    
    // MARK: - Navigation
   
}
