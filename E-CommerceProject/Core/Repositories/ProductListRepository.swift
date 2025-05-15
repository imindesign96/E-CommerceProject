//
//  ProductRepository.swift
//  E-CommerceProject
//
//  Created by Phan Ngoc Vu on 2025/05/16.
//


protocol ProductListRepository {
    func getProducts(page: Int, limit: Int, query: String) async throws -> [Product]
}
