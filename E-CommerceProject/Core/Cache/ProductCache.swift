//
//  ProductCache.swift
//  E-CommerceProject
//
//  Created by Phan Ngoc Vu on 2025/05/16.
//


actor ProductCache {
    private var products: [String: [Product]] = [:]
    
    func getProducts(for query: String) -> [Product]? {
        return products[query]
    }
    
    func setProducts(_ products: [Product], for query: String) {
        self.products[query] = products
    }
    
    func clearCache() {
        products.removeAll()
    }
}
