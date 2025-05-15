//
//  Product.swift
//  E-CommerceProject
//
//  Created by Phan Ngoc Vu on 2025/05/16.
//

// Core/Models/Product.swift
struct Product: Codable, Identifiable {
    let id: String
    let name: String
    let price: Double
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case price
        case description
    }
    
    // Init thông thường để tạo Product trực tiếp
    init(id: String, name: String, price: Double, description: String) {
        self.id = id
        self.name = name
        self.price = price
        self.description = description
    }
    
    // Decodable: Giải mã từ JSON
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let intId = try container.decode(Int.self, forKey: .id)
        self.id = String(intId)
        self.name = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(Double.self, forKey: .price)
        self.description = try container.decode(String.self, forKey: .description)
    }
    
    // Encodable: Mã hóa thành JSON
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Int(id) ?? 0, forKey: .id) // Chuyển String id thành Int cho DummyJSON
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(description, forKey: .description)
    }
}
