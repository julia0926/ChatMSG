//
//  NewMessageInteractor.swift
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

protocol NewMessageBusinessLogic {
    func requestNewMessage()
    func saveNewMessage()
}

protocol NewMessageDataStore {
    var receiver: String? { get set }
    var sender: String? { get set }
    var date: Date? { get set }
    var type: String? { get set }
    var writingStyle: String? { get set }
    var situation: String? { get set }
}

final class NewMessageInteractor: NewMessageBusinessLogic, NewMessageDataStore {
    
    static let shared = NewMessageInteractor()
    
    var receiver: String?
    var sender: String?
    var date: Date?
    var type: String?
    var writingStyle: String?
    var situation: String? 

    var presenter: NewMessagePresentationLogic?
    private var worker: NewMessageWorkerProtocol?
        
    init(presenter: NewMessagePresentationLogic = NewMessagePresenter(),
         worker: NewMessageWorker = NewMessageWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
  
    func requestNewMessage() {
        guard let worker = worker else { return }
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let message = try await worker.requestNewMessage(self.makeRequest())
                let response = MakeMessage.makeNewMessage.Response(newMessage: message)
                presenter?.presentRequestedMessage(response: response)
            } catch {
                presenter?.presentRequestedMessageError(response: .init(message: error.localizedDescription))
            }
        }
    }
    
    func saveNewMessage() {
        guard let worker = worker else { return }
        Task {
            await worker.saveNewMessage(makeRequest())
        }
    }
    
    private func makeRequest() -> MakeMessage.makeNewMessage.Request {
        return MakeMessage.makeNewMessage.Request(receiver: self.receiver ?? "",
                                                         sender: self.sender ?? "",
                                                         date: self.date ?? .now,
                                                         type: removeImoji(self.type),
                                                         writingStyle: self.writingStyle ?? "",
                                                         situation: self.situation ?? "")
    }
    
    private func removeImoji(_ origin: String?) -> String {
        if let splitStr: String.SubSequence = self.type?.split(separator: " ").last {
            return String(splitStr)
        }
        return ""
    }
    

    

}
