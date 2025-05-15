//
//  AddProductUseCase.swift
//  E-CommerceProject
//
//  Created by Phan Ngoc Vu on 2025/05/16.
//


protocol AddProductUseCase {
    func execute(product: Product) async throws
}

class AddProductUseCaseImpl: AddProductUseCase {
    private let repository: AddProductRepository
    
    init(repository: AddProductRepository) {
        self.repository = repository
    }
    
    func execute(product: Product) async throws {
        try await repository.addProduct(product)
    }
}
