//
//  dataFirstGet.swift
//  Deals
//
//  Created by admin on 8/7/19.
//  Copyright © 2019 admin. All rights reserved.
//

import CoreData
import UIKit

class DataFirstGet {
    
    static func dataInit(completion: @escaping
        ( _ context:  NSManagedObjectContext) -> ())  {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        completion(context)
        
    }
    
    
}
