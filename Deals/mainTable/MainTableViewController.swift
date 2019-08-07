//
//  MainTableViewController.swift
//  Deals
//
//  Created by admin on 7/28/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController,
NSFetchedResultsControllerDelegate {
    
    var arrayMeets: [Meets] = []
    var meets: Meets?
    var index = 0
    var fetchResultsController: NSFetchedResultsController<Meets>!
    var filteredResultArray: [Meets] = []
    var context: NSManagedObjectContext!
    
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getData()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
    //MARK - Download current data from coreData
    
    func getData() {
        
        DataFirstGet.dataInit { (context) in
            //запрос
            let fetchRequest: NSFetchRequest<Meets> = Meets.fetchRequest()
            //указание того как мы хотим видеть выходные данные сортируме по нейм
            let sortDescriptor = NSSortDescriptor(key: "information",ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            //инцииализировали и передали ему аргументы
            self.fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            self.fetchResultsController.delegate = self
            
            do {
                //если данные пришли
                try self.fetchResultsController.performFetch()
                //то мы добавляем их в массив
                self.arrayMeets = self.fetchResultsController.fetchedObjects!
            } catch let error as NSError {
                print("Error: \(error)")
            }
        }
       
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMeets.count
    }
    
    @IBAction func unwindSeque(segue: UIStoryboardSegue) {
        self.tableView.reloadData()
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
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(action)
        ac.addAction(secondAction)
        ac.addAction(cancelAction)
        
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "Удалить ") { (action, indexPath) in

            DataDelete.deleteData(&self.arrayMeets,indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
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
                dvc.index = indexPath
            }
        }
        
    }
    
}
