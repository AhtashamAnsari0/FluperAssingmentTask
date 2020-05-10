//
//  DatabaseHelper.swift
//  FluperTask
//
//  Created by Ahtasham Ansari on 10/05/20.
//  Copyright © 2020 AhtashamAnsari. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    
    static var shareInstance = DatabaseHelper()
    private init() { }
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func parse(_ jsonData: Data) -> Bool {
        do {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve managed object context")
            }
            let decoder = JSONDecoder()
            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = context
            _ = try decoder.decode([NewsHeadline].self, from: jsonData)
            try context?.save()
            return true
        } catch let error {
            print(error)
            return false
        }
    }
    
    func fetchNewsHeadline()-> [NewsHeadline] {
        var news = [NewsHeadline]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NewsHeadline")
        do {
            news = try context?.fetch(fetchRequest) as? [NewsHeadline] ?? []
        } catch let error{
            print(error.localizedDescription)
        }
        return news
    }
}

