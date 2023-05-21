//
//  ProductRepositoryMock.swift
//
//
//  Created by Wesley Brito on 21/05/23.
//

import Combine
@testable import DataLayer

class ProductRepositoryMock: ProductRepositoryProtocol {
    func fetchProducts() async throws -> [ProductDTO] {
        // Simulate network delay
        await Task.sleep(1_000_000_000) // sleep for 1 second
        
        // Replace the following with whatever mock data you want to return
        let mockProducts = [ProductDTO(id: 1, title: "Test Product", price: 10.0, description: "This is a test product", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", category: "test"),
                            ProductDTO(id: 2, title: "Test Product2", price: 20.0, description: "This is a test product2", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", category: "test")]
        return mockProducts
    }
}
