//
//  CoreDataManager.swift
//  ChatMSG
//
//  Created by Julia on 2023/05/04.
//

import CoreData
import UIKit

final class CoreDataManager {
    
    static var shared: CoreDataManager = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    private init(persistentContainer: NSPersistentContainer = NSPersistentContainer(name: "MessageModel")) {
        self.persistentContainer = persistentContainer
        self.persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initailize MessageModel \(error)")
            }
        }
    }
    
    var viewContext: NSManagedObjectContext {
      return persistentContainer.viewContext
    }
    
    lazy var backgroundContext: NSManagedObjectContext = {
      let newbackgroundContext = persistentContainer.newBackgroundContext()
      newbackgroundContext.automaticallyMergesChangesFromParent = true
      return newbackgroundContext
    }()

}
