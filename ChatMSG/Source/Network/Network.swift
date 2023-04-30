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
        
    @frozen enum Constants {
        static let key = "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"
    }
    
    private var client: OpenAISwift?
    
    init() {
        self.client = OpenAISwift(authToken: Constants.key)
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
                    let output = model.choices?.first?.text ?? "결과가 없습니다."
                    continuation.resume(with: .success(output))
                case.failure(let error):
                    continuation.resume(with: .failure(error))

                }
            })
        })
    }
    
    private func makeRequest(_ request: OpenAIRequest) -> String {
        let request = """
        다음 정보를 기반으로 자세하게 메세지를 자세히 작성해줘.
        \(request.type)의 여러 예시를 기반으로 자연스러운 문장으로 메세지를 구성해줘.
        한국어 문장이 자연스럽게 작성해줘.
        
          - 메세지 유형 : \(request.type)
          - 받는 사람 : \(request.receiver)
          - 보내는 사람 : \(request.sender)
          - 날짜 : \(request.date)
          - 어체 : \(request.stylistic)
          - 장소 : \(request.location)
          - 메세지 길이 : \(request.length)
          - 상황 설명 : \(request.situation)
        """
        print(request)
        return request
    }
    
}
