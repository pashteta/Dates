//
//  dataGet.swift
//  Deals
//
//  Created by admin on 7/29/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import CoreData

class DataGet {
    
    // добираемся до контекста
    private var fetchResultsController: NSFetchedResultsController<Meets>!
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    func getValue(_ arrayButtons: [UIButton], _ arrayFields: [UITextField] ) {
        
        let context = appDelegate.persistentContainer.viewContext
        //создаем экземляр нашего класса в нашем контексте
        let arrayMeets = Meets(context: context)
        
        //устанавливаем значения для всех его свойств
        
        for (index,item) in arrayFields.enumerated() {
            
            switch index {
            case 0:
                arrayMeets.name = item.text
            case 1:
                arrayMeets.information = item.text
            case 2:
                arrayMeets.place = item.text
            default:
                return
            }
        }
        
        for elementsButton in arrayButtons {
            if elementsButton.backgroundColor == UIColor.red {
                let valueTag = elementsButton.tag
                arrayMeets.priority = String(valueTag)
            }
        }
        
        //пытаемся сохранить значения
        do {
            try context.save()
            print("Сохранение удалось  ")
        } catch let error as NSError {
            print("Не удалось сохранить данные \(error),\(error.userInfo)")
        }
    }
    
    
}
