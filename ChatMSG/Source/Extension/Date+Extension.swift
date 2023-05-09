//
//  Date+Extension.swift
//  ChatMSG
//
//  Created by Julia on 2023/05/04.
//

import Foundation

extension Date {
    
    func slashFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter.string(from: self)
    }
    
    func hangleFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: self)
    }
}
