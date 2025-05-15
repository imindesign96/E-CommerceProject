//
//  ProductListViewModel.swift
//  E-CommerceProject
//
//  Created by Phan Ngoc Vu on 2025/05/16.
//


import Combine

class ProductListViewModel: ObservableObject {
    private let getProductsUseCase: GetProductsUseCase
    @Published var products: [Product] = []
    @Published var errorMessage: String?
    @Published var currentPage: Int = 1
    private let itemsPerPage: Int = 5
    @Published var searchQuery: String = ""
    
    init(getProductsUseCase: GetProductsUseCase) {
        self.getProductsUseCase = getProductsUseCase
    }
    
    func fetchProducts() {
        Task { @MainActor in
            do {
                let products = try await getProductsUseCase.execute(page: currentPage, limit: itemsPerPage, query: searchQuery)
                self.products = products
                self.errorMessage = nil
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func nextPage() {
        currentPage += 1
        fetchProducts()
    }
    
    func prevPage() {
        if currentPage > 1 {
            currentPage -= 1
            fetchProducts()
        }
    }
}