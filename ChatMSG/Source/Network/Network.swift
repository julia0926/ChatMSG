//
//  Network.swift
//  ChatMSG
//
//  Created by Julia on 2023/04/26.
//

import Foundation
import OpenAISwift

protocol NetworkProtocol {
    func request(_ request: String, complection: @escaping (Result<String, Error>) -> Void)
}

final class Network: NetworkProtocol {
    
    
    static let shared = Network()
        
    @frozen enum Constants {
        static let key = "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"
    }
    
    private var client: OpenAISwift?
    
    init() { }
    
    func setup() {
        self.client = OpenAISwift(authToken: Constants.key)
    }

    func request(_ request: String, complection: @escaping (Result<String, Error>) -> Void) {
        client?.sendCompletion(with: request,
                               model: .gpt3(.davinci),
                               maxTokens: 2048,
                               completionHandler: { result in
            switch result {
            case .success(let model):
                print("성공", String(describing: model))
                let output = model.choices?.first?.text ?? ""
                complection(.success(output))
            case.failure(let error):
                complection(.failure(error))

            }
        })
    }
    
}
