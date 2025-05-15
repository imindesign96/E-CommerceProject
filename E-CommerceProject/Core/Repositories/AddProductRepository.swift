//
//  ProductRepository.swift
//  E-CommerceProject
//
//  Created by Phan Ngoc Vu on 2025/05/16.
//


protocol AddProductRepository {
    func addProduct(_ product: Product) async throws
}
