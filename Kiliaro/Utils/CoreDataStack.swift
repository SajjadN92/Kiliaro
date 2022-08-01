//
//  CoreDataStack.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import CoreData

class CoreDataStack {
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Kiliaro")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static var viewContext = persistentContainer.viewContext
    static var backgroundContext = persistentContainer.newBackgroundContext()
}
