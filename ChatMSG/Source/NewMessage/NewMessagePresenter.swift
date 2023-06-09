//
//  NewMessagePresenter.swift
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

protocol NewMessagePresentationLogic {
    func presentRequestedMessage(response: MakeMessage.makeNewMessage.Response)
    func presentRequestedMessageError(response: MakeMessage.makeNewMessage.Response.Error)
}

final class NewMessagePresenter: NewMessagePresentationLogic {
    
    weak var viewController: NewMessageDisplayLogic?
      
    func presentRequestedMessage(response: MakeMessage.makeNewMessage.Response) {
        let viewModel = MakeMessage.makeNewMessage.ViewModel(displayedMessage: response.newMessage)
        Task { @MainActor in
            viewController?.displayNewMessage(viewModel: viewModel)
        }
    }
    
    func presentRequestedMessageError(response: MakeMessage.makeNewMessage.Response.Error) {
        let error = MakeMessage.makeNewMessage.ViewModel.Error(message: response.message)
        Task { @MainActor in
            viewController?.displayError(error: error)
        }
    }
}
