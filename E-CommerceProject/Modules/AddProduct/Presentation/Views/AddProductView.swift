//
//  AddProductView.swift
//  E-CommerceProject
//
//  Created by Phan Ngoc Vu on 2025/05/16.
//


import SwiftUI

struct AddProductView: View {
    @ObservedObject var viewModel: AddProductViewModel
    @Environment(\.dismiss) var dismiss
    let onDismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Tên sản phẩm", text: $viewModel.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Giá", text: $viewModel.price)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
            
            TextField("Mô tả", text: $viewModel.description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            Button("Thêm") {
                viewModel.addProduct()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding()
        .navigationTitle("Thêm Sản phẩm")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Hủy") {
                    dismiss()
                    onDismiss()
                }
            }
        }
        .onChange(of: viewModel.isSuccess) { isSuccess in
            if isSuccess {
                dismiss()
                onDismiss()
            }
        }
    }
}