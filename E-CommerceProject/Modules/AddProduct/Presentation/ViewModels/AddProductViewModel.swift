//
//  AddProductViewModel.swift
//  E-CommerceProject
//
//  Created by Phan Ngoc Vu on 2025/05/16.
//


import Combine
import Foundation

class AddProductViewModel: ObservableObject {
    private let addProductUseCase: AddProductUseCase
    @Published var name: String = ""
    @Published var price: String = ""
    @Published var description: String = ""
    @Published var errorMessage: String?
    @Published var isSuccess: Bool = false
    
    init(addProductUseCase: AddProductUseCase) {
        self.addProductUseCase = addProductUseCase
    }
    
    func addProduct() {
        guard !name.isEmpty else {
            errorMessage = "Vui lòng nhập tên sản phẩm."
            return
        }
        
        guard let priceValue = Double(price), priceValue > 0 else {
            errorMessage = "Vui lòng nhập giá hợp lệ."
            return
        }
        
        guard !description.isEmpty else {
            errorMessage = "Vui lòng nhập mô tả."
            return
        }
        
        let product = Product(id: UUID().uuidString, name: name, price: priceValue, description: description)
        
        Task { @MainActor in
            do {
                try await addProductUseCase.execute(product: product)
                isSuccess = true
                errorMessage = nil
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
