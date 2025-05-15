//
//  ProductRepositoryImpl.swift
//  E-CommerceProject
//
//  Created by Phan Ngoc Vu on 2025/05/16.
//


class ProductRepositoryImpl: ProductListRepository, AddProductRepository {
    private let api: ProductAPI
    
    init(api: ProductAPI) {
        self.api = api
    }
    
    func getProducts(page: Int, limit: Int, query: String) async throws -> [Product] {
        try await api.fetchProducts(page: page, limit: limit, query: query)
    }
    
    func addProduct(_ product: Product) async throws {
        try await api.addProduct(product)
    }
}
