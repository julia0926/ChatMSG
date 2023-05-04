//
//  OpenAIDataSource.swift
//  ChatMSG
//
//  Created by Julia on 2023/04/26.
//

import Foundation
import OpenAISwift

protocol OpenAIDataSourceProtocol {
    func getMessage(request: OpenAIRequest) async throws -> String
}

final class OpenAIDataSource: OpenAIDataSourceProtocol {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    func getMessage(request: OpenAIRequest) async throws -> String {
        return try await network.request(request)
    }
}
