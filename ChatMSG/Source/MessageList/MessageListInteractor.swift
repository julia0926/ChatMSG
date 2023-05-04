//
//  MessageListInteractor.swift
//  ChatMSG
//
//  Created by Julia on 2023/04/26.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MessageListBusinessLogic {
    func fetchMessageList()
}

protocol MessageListDataStore {
    var messageList: [MessageInfoModel] { get set }
}

final class MessageListInteractor: MessageListBusinessLogic, MessageListDataStore {
    var messageList: [MessageInfoModel] = []
    var presenter: MessageListPresentationLogic?
    private var worker: MessageListWorkerProtocol?
  
    // MARK: - do Something
    init(presenter: MessageListPresentationLogic = MessageListPresenter(),
         worker: MessageListWorkerProtocol = MessageListWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
  

    func fetchMessageList() {
        guard let worker = worker else { return }
        Task {
            let messages: [MessageInfoModel] = await worker.fetchMessage()
            self.messageList = messages
            let response = MessageList.Something.Response(messageList: self.messageList)
            presenter?.presentMessageList(response: response)
        }
    }
}
