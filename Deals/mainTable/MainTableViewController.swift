//
//  MainTableViewController.swift
//  Deals
//
//  Created by admin on 7/28/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController,NSFetchedResultsControllerDelegate {

    var arrayMeets: [Meets] = []
    var meets: Meets?
    var index = 0
    var fetchResultsController: NSFetchedResultsController<Meets>!
    var filteredResultArray: [Meets] = []
    
    @IBOutlet weak var sortButton: UIBarButtonItem!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        //запрос
        let fetchRequest: NSFetchRequest<Meets> = Meets.fetchRequest()
        //указание того как мы хотим видеть выходные данные сортируме по нейм
        let sortDescriptor = NSSortDescriptor(key: "information",ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
            //инцииализировали и передали ему аргументы
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            do {
                //если данные пришли
                try fetchResultsController.performFetch()
                //то мы добавляем их в массив
                arrayMeets = fetchResultsController.fetchedObjects!
            } catch let error as NSError {
                print("Error: \(error)")
            }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMeets.count
    }

    @IBAction func unwindSeque(segue: UIStoryboardSegue) {
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellMain", for: indexPath) as! MainTableViewCell

        let mycell = configurecell(cell,indexPath)
       
        return mycell
    }
    
    @IBAction func sortAction(_ sender: Any) {
        
        let ac = UIAlertController(title: "Choose sort", message: "Выберите одну из сортировок", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "By Priority", style: .default) { (arrayMeets) in
            print("Sort")
        }
        
        let secondAction = UIAlertAction(title: "by Name", style: .default) { (arrayMeets) in
            print("Sort2")
        }
        
        ac.addAction(action)
        ac.addAction(secondAction)
        
        present(ac,animated: true,completion:nil)
        
    }
    
    func configurecell(_ myCell: MainTableViewCell,_ indexPath: IndexPath) -> UITableViewCell{
        
        meets = arrayMeets[indexPath.row]
      
        myCell.nameLabel.text = meets?.name
        myCell.dateLabel.text = "non date"
        switch meets?.priority {
        case "0":
            myCell.priorityLabel.text = "High"
        case "1":
            myCell.priorityLabel.text = "Medium"
        case "2":
            myCell.priorityLabel.text = "Low"
        default:
           myCell.priorityLabel.text = "High"
        }
        
        return myCell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "Удалить ") { (action, indexPath) in
            self.arrayMeets.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let objectToDelete = self.fetchResultsController.object(at: indexPath)
            context.delete(objectToDelete)
        }
        
        delete.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        
        return [delete]
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue" {
            //определяем нужный индек в таблице
            if let indexPath = tableView.indexPathForSelectedRow {
                let dvc = segue.destination as! InfoTableViewController
                dvc.arrayMeets = arrayMeets
                dvc.index = indexPath.row
            }
        }
        
    }


}
