//
//  ProductDTO.swift
//  
//
//  Created by Wesley Brito on 21/05/23.
//

import Foundation

struct ProductDTO: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let image: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case description
        case image
        case category
    }
    
    public init(
        id: Int,
        title: String,
        price: Double,
        description: String,
        image: String,
        category: String
    ) {
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.image = image
        self.category = category
    }
    
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.price = try container.decodeIfPresent(Double.self, forKey: .price) ?? 0
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        self.category = try container.decodeIfPresent(String.self, forKey: .category) ?? ""
    }
}
