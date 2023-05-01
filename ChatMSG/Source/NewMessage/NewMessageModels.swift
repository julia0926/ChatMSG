//
//  NewMessageModels.swift
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

enum NewMessage {
    // MARK: -  Use Cases
      enum makeNewMessage {
          
        struct Request {
            ///메세지 유형
            let type: String
            /// 수신자
            let receiver: String
            ///송신자
            let sender: String
            ///메세지에 담길 날짜
            let date: Date
            ///어체
            let stylistic: String
            ///메세지에 담길 장소
            let location: String?
            ///메세지 길이
            let length: Int
            ///자세한 상황 설명
            let situation: String
        }

        struct Response {
            var newMessage: String
        }
          
        struct ViewModel {
            var displayedMessage: String
        }
    }
}