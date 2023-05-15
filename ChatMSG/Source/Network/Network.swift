//
//  Network.swift
//  ChatMSG
//
//  Created by Julia on 2023/04/26.
//

import Foundation
import OpenAISwift

protocol NetworkProtocol {
    func request(_ request: OpenAIRequest) async throws -> String
}

final class Network: NetworkProtocol {
            
    private var client: OpenAISwift?
    
    init(client: OpenAISwift = OpenAISwift(authToken: Bundle.main.apiKey)) {
        self.client = client
    }

    func request(_ request: OpenAIRequest) async throws -> String {
        return try await withCheckedThrowingContinuation({ continuation in
            let request = makeRequest(request)
            client?.sendCompletion(with: request,
                                   model: .gpt3(.davinci),
                                   maxTokens: 2024,
                                   completionHandler: { result in
                switch result {
                case .success(let model):
                    let output = model.choices?.first?.text ?? ""
                    continuation.resume(with: .success(output))
                case.failure(let error):
                    continuation.resume(with: .failure(error))

                }
            })
        })
    }
    
    private func makeRequest(_ request: OpenAIRequest) -> String {
        let request = """
        다음 정보를 기반으로 최대한 자세하게 메세지를 작성해줘.
        \(request.type) 메세지의 여러 예시를 기반으로 메세지를 구성해줘.
        상황 설명의 내용이 모두 포함되게 한국어가 자연스러운 문장으로 메세지를 만들어줘

          - 받는 사람 : \(request.receiver)
          - 보내는 사람 : \(request.sender)
          - 어체 : \(request.writingStyle)
          - 상황 설명 : \(request.situation)
          - 상황 속 날짜 : \(request.date)
        """
        print(request)
        return request
    }
    
}
