//
//  MessageDetailInteractor.swift
//  ChatMSG
//
//  Created by Julia on 2023/05/04.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MessageDetailBusinessLogic {
    func fetchMessage(request: MessageDetail.Something.Request)
}

protocol MessageDetailDataStore {
    var message: MessageItem? { get set }
}

final class MessageDetailInteractor: MessageDetailBusinessLogic, MessageDetailDataStore {
    var presenter: MessageDetailPresentationLogic?
    var message: MessageItem?
    
    // MARK: - do Something
  
    func fetchMessage(request: MessageDetail.Something.Request) {
        if let message = message {
            let response = MessageDetail.Something.Response(message: message)
            presenter?.presentSomething(response: response)
        } else {
            
        }

    }
}
