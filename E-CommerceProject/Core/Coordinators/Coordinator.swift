//
//  Coordinator.swift
//  E-CommerceProject
//
//  Created by Phan Ngoc Vu on 2025/05/16.
//

import SwiftUICore

protocol Coordinator: AnyObject {
    func start() -> AnyView
    func showProductList() -> AnyView
    func showAddProduct(onDismiss: @escaping () -> Void) -> AnyView
}
