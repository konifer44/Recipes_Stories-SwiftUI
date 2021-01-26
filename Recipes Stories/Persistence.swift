//
//  Persistence.swift
//  Recipies Stories
//
//  Created by Jan Konieczny on 03/11/2020.
//

import Foundation
import CoreData


class PersistenceController {
    static let shared = PersistenceController()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Recipies_Stories")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error)
            }
            
        }
        return container
    }()
    
    private init() {
        
    }
    
    public func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            }catch {
                print(error)
            }
        }
    }
}

