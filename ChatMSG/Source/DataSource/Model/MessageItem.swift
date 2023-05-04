//
//  MessageItem.swift
//  ChatMSG
//
//  Created by Julia on 2023/05/04.
//

import Foundation
import CoreData

struct MessageItem {
    private let message: Message
    
    init(message: Message) {
        self.message = message
    }
    
    var id: NSManagedObjectID {
        return message.objectID
    }
    
    var receiver: String {
        return message.receiver ?? ""
    }
    
    var sender: String {
        return message.sender ?? ""
    }
    
    var type: String {
        return message.type ?? ""
    }
    
    var imoji: String {
        return message.imoji ?? ""
    }
    
    var result: String {
        return message.result ?? ""
    }
    
    var messageDate: Date {
        return message.messageDate ?? .now
    }
    
    var createdDate: Date {
        return .now
    }
}
