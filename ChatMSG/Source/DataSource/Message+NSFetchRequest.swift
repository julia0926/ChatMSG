//
//  Message+NSFetchRequest.swift
//  ChatMSG
//
//  Created by Julia on 2023/05/04.
//

import Foundation
import CoreData

extension Message {
    
    static var viewContext: NSManagedObjectContext {
        return CoreDataManager.shared.viewContext
    }
    
    static var backgroundContext: NSManagedObjectContext {
        return CoreDataManager.shared.backgroundContext
    }
    
    static var all: NSFetchRequest<Message> = {
        let request: NSFetchRequest<Message> = Message.fetchRequest()
        request.sortDescriptors = [.init(keyPath: \Message.createdDate, ascending: true)]
        return request
    }()
    
    private static func byId(in context: NSManagedObjectContext, id: NSManagedObjectID) -> Message? {
        do {
            return try context.existingObject(with: id) as? Message
        } catch {
            return nil
        }
    }
    
    private static func fetchDiaryFaults() async -> [Message] {
        let messages: [Message] = await backgroundContext.perform {
            do {
                return try backgroundContext.fetch(Message.all)
            } catch {
                return []
            }
        }
        return messages
    }
    
    static func fetchAllMessage() async -> [MessageItem] {
        print("fetchAllMessage!!!")
        let diariesID = await fetchDiaryFaults().map { $0.objectID }
        return diariesID.compactMap{ Message.byId(in: viewContext, id: $0) }.map(MessageItem.init)
    }
    
    static func saveMessage(receiver: String,
                            sender: String,
                            messageDate: Date,
                            result: String,
                            type: String,
                            imoji: String) async {
        await backgroundContext.perform {
            let message = Message(context: backgroundContext)
            message.receiver = receiver
            message.sender = sender
            message.messageDate = messageDate
            message.result = result
            message.type = type
            message.createdDate = .now
            message.imoji = imoji
            do {
                try backgroundContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    static func deleteMessage(message: MessageItem) async {
        await backgroundContext.perform {
            let message = byId(in: backgroundContext, id: message.id)
            do {
                if let message = message {
                    backgroundContext.delete(message)
                    try backgroundContext.save()
                    print("삭제!!")
                }
                
          } catch {
              backgroundContext.rollback()
          }
        }
    }
  
}
