//
//  MessageListWorker.swift
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

protocol MessageListWorkerProtocol {
    func fetchMessage() async -> [MessageInfo]
}

final class MessageListWorker: MessageListWorkerProtocol {
    
    func fetchMessage() async -> [MessageInfo] {
        let messages: [MessageInfo] = await Message.fetchAllMessage().map {
            self.translate($0)
        }
        return messages
    }
    
    /// 서버 모델 데이터를 내부 모델로 변경합니다.
    func translate(_ data: MessageItem) -> MessageInfo {
        return .init(receiver: data.receiver,
                     sender: data.sender,
                     type: data.type,
                     imoji: data.imoji,
                     result: data.result,
                     messageDate: data.messageDate,
                     createdDate: data.createdDate)
    }
    
}
