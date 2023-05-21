//
//  ProductRepository.swift
//  
//
//  Created by Wesley Brito on 21/05/23.
//

import Foundation
import Combine

public protocol ProductRepositoryProtocol {
    @available(macOS 10.15, *)
    func fetchProducts() async throws -> [ProductDTO]
}

@available(macOS 10.15, *)
struct ProductRepository: ProductRepositoryProtocol {
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchProducts() async throws -> [ProductDTO] {
        return try await apiService.request(.getProducts)
    }
}
