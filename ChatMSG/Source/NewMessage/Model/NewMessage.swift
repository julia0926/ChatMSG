//
//  NewMessage.swift
//  ChatMSG
//
//  Created by Julia on 2023/05/02.
//

import Foundation

struct NewMessage {
    /// 수신자
    var receiver: String
    ///송신자
    var sender: String
    ///메세지에 담길 날짜
    var date: Date
    ///메세지 유형
    var type: String
    ///어체
    var stylistic: String
    ///메세지 길이
    var length: Int
    ///자세한 상황 설명
    var situation: String
}
