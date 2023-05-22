//
//  ProductRepository.swift
//  
//
//  Created by Wesley Brito on 21/05/23.
//

import Foundation
import Combine

public protocol ProductRepositoryProtocol {
    @available(iOS 15.0, *)
    @available(macOS 10.15, *)
    func fetchProducts() async throws -> [ProductDTO]
}

@available(iOS 15.0, *)
@available(macOS 10.15, *)
public struct ProductRepository: ProductRepositoryProtocol {
    private let apiService: APIServiceProtocol

    public init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    public func fetchProducts() async throws -> [ProductDTO] {
        return try await apiService.request(.getProducts)
    }
}
