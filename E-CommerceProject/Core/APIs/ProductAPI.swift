//
//  ProductAPI.swift
//  E-CommerceProject
//
//  Created by Phan Ngoc Vu on 2025/05/16.
//

import SwiftUI

protocol ProductAPI {
    func fetchProducts(page: Int, limit: Int, query: String) async throws -> [Product]
    func addProduct(_ product: Product) async throws
}

class ProductAPIImpl: ProductAPI {
    private let baseURL = "https://dummyjson.com"
    private let cache: ProductCache
    
    init(cache: ProductCache) {
        self.cache = cache
    }
    
    func fetchProducts(page: Int, limit: Int, query: String) async throws -> [Product] {
        if let cachedProducts = await cache.getProducts(for: query) {
            return cachedProducts
        }
        
        let skip = (page - 1) * limit
        let urlString = "\(baseURL)/products?limit=\(limit)&skip=\(skip)&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let pageResponse = try decoder.decode(PageResponse.self, from: data)
        
        await cache.setProducts(pageResponse.products, for: query)
        
        return pageResponse.products
    }
    
    func addProduct(_ product: Product) async throws {
        guard let url = URL(string: "\(baseURL)/products/add") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(product)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        await cache.clearCache()
    }
}

struct PageResponse: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
