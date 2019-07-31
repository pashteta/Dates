//
//  dataDeleate.swift
//  Deals
//
//  Created by admin on 7/31/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataDelete {
    
    static func deleteData <T> (_ arrayList: inout [T], _ index: IndexPath?) -> [T] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        if let index = index {
            context.delete(arrayList[index.row] as! NSManagedObject)
            arrayList.remove(at: index.row )
        }
        
        do {
            try context.save()
        } catch let error {
            print("Error: \(error)")
        }
        
        return arrayList
    }
    
    
}
