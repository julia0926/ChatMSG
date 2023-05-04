//
//  OpenAIRequest.swift
//  ChatMSG
//
//  Created by Julia on 2023/04/27.
//

import Foundation

struct OpenAIRequest {
    ///메세지 유형
    let type: String
    /// 수신자
    let receiver: String
    ///송신자
    let sender: String
    ///메세지에 담길 날짜
    let date: String
    ///어체
    let writingStyle: String
    ///자세한 상황 설명
    let situation: String
}
