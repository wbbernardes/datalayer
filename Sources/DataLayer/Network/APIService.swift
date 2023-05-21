//
//  APIService.swift
//
//
//  Created by Wesley Brito on 21/05/23.
//

import Combine
import Foundation

protocol NetworkSession {
    @available(macOS 10.15, *)
    func customDataTaskPublisher(for request: URLRequest) async throws -> (Data, URLResponse)
}

// Extend URLSession to conform to NetworkSession
extension URLSession: NetworkSession {
    @available(macOS 10.15, *)
    func customDataTaskPublisher(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await customDataTaskPublisher(for: request)
    }
}

protocol APIServiceProtocol {
    @available(macOS 10.15, *)
    func request<T: Decodable>(_ target: APITarget) async throws -> T
}

class APIService: APIServiceProtocol {
    private let session: NetworkSession

    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    @available(macOS 10.15, *)
    func request<T: Decodable>(_ target: APITarget) async throws -> T {
        var request = URLRequest(url: target.url)
        request.httpMethod = target.method
        request.allHTTPHeaderFields = target.headers
        
        if target.method == "POST" {
            request.httpBody = try? JSONSerialization.data(withJSONObject: target.task, options: .prettyPrinted)
        }
        
        let (data, response) = try await session.customDataTaskPublisher(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return try JSONDecoder().decode(T.self, from: data)
        case 400:
            throw APIError.badRequest
        case 401:
            throw APIError.unauthorized
        case 403:
            throw APIError.forbidden
        case 404:
            throw APIError.notFound
        case 500:
            throw APIError.serverError
        default:
            throw APIError.unknown
        }
    }
}
