//
//  MessageListRouter.swift
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

protocol MessageListRoutingLogic {
    func routeToMessageDetail(index: Int)
    func routeToNewMessage()
}

protocol MessageListDataPassing {
    var dataStore: MessageListDataStore? { get }
}

final class MessageListRouter: MessageListRoutingLogic, MessageListDataPassing {
    
    weak var listVC: MessageListViewController?
    weak var newMessageVC: ReceiverViewController?
    var dataStore: MessageListDataStore?
  

    // MARK: -  Routing
    
    func routeToMessageDetail(index: Int) {
        let detailVC = MessageDetailViewController()
        guard let dataStore = dataStore,
              var detailDataStore = detailVC.router?.dataStore,
              let vc = listVC else {
            return
        }
        vc.navigationController?.pushViewController(detailVC, animated: true)
        detailDataStore.message = dataStore.messageList[index]
    }

    func routeToNewMessage() {
        let newMessageVC = ReceiverViewController()
        guard let vc = listVC else { return }
        vc.navigationController?.pushViewController(newMessageVC, animated: true)

    }
    
}
