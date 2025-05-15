//
//  AppCoordinator.swift
//  E-CommerceProject
//
//  Created by Phan Ngoc Vu on 2025/05/16.
//

import SwiftUI

class AppCoordinator: Coordinator {
    private let productAPI: ProductAPI
    private let cache = ProductCache()
    
    init() {
        self.productAPI = ProductAPIImpl(cache: cache)
    }
    
    func start() -> AnyView {
        showProductList()
    }
    
    func showProductList() -> AnyView {
        let repository = ProductRepositoryImpl(api: productAPI)
        let useCase = GetProductsUseCaseImpl(repository: repository)
        let viewModel = ProductListViewModel(getProductsUseCase: useCase)
        let view = ProductListView(viewModel: viewModel, coordinator: self)
        return AnyView(NavigationView { view })
    }
    
    func showAddProduct(onDismiss: @escaping () -> Void) -> AnyView {
        let repository = ProductRepositoryImpl(api: productAPI)
        let useCase = AddProductUseCaseImpl(repository: repository)
        let viewModel = AddProductViewModel(addProductUseCase: useCase)
        let view = AddProductView(viewModel: viewModel, onDismiss: onDismiss)
        return AnyView(view)
    }
}
