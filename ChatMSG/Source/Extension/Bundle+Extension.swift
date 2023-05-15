//
//  Bundle+Extension.swift
//  ChatMSG
//
//  Created by Julia on 2023/05/15.
//

import Foundation

extension Bundle {
    var apiKey: String {
        guard let file = self.path(forResource: "OpenAIInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["API_KEY"] as? String
        else { fatalError("API KEY를 가져오는데 실패하였습니다.") }
        return key
    }
}
