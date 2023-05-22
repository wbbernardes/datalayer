//
//  ProductRepository.swift
//  
//
//  Created by Wesley Brito on 21/05/23.
//

import Foundation
import Combine
import Domain

@available(iOS 15.0, *)
@available(macOS 10.15, *)
public struct ProductRepository: ProductRepositoryProtocol {
    private let apiService: APIServiceProtocol

    public init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    public func fetchProducts() async throws -> [Product] {
        let object: [ProductDTO] = try await apiService.request(.getProducts)
        return object.map { $0.toDomain() }
    }
}
