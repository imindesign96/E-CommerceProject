//
//  GetProductsUseCase.swift
//  E-CommerceProject
//
//  Created by Phan Ngoc Vu on 2025/05/16.
//

protocol GetProductsUseCase {
    func execute(page: Int, limit: Int, query: String) async throws -> [Product]
}

class GetProductsUseCaseImpl: GetProductsUseCase {
    private let repository: ProductListRepository
    
    init(repository: ProductListRepository) {
        self.repository = repository
    }
    
    func execute(page: Int, limit: Int, query: String) async throws -> [Product] {
        try await repository.getProducts(page: page, limit: limit, query: query)
    }
}
