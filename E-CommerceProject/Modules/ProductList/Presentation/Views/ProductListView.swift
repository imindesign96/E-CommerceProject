//
//  ProductListView.swift
//  E-CommerceProject
//
//  Created by Phan Ngoc Vu on 2025/05/16.
//


import SwiftUI

struct ProductListView: View {
    @ObservedObject var viewModel: ProductListViewModel
    let coordinator: Coordinator
    
    var body: some View {
        VStack {
            // Thanh tìm kiếm
            TextField("Tìm kiếm sản phẩm...", text: $viewModel.searchQuery, onCommit: {
                viewModel.currentPage = 1
                viewModel.fetchProducts()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            
            // Thông báo lỗi
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            // Danh sách sản phẩm
            List(viewModel.products) { product in
                VStack(alignment: .leading) {
                    Text(product.name)
                        .font(.headline)
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.subheadline)
                    Text(product.description)
                        .font(.caption)
                }
            }
            
            // Điều khiển phân trang
            HStack {
                Button("Trang trước") {
                    viewModel.prevPage()
                }
                .disabled(viewModel.currentPage == 1)
                .padding()
                
                Spacer()
                
                Button("Trang sau") {
                    viewModel.nextPage()
                }
                .padding()
            }
        }
        .navigationTitle("Danh sách Sản phẩm")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Điều hướng sang màn hình thêm sản phẩm
                    // SwiftUI sẽ xử lý qua NavigationLink hoặc Sheet
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            viewModel.fetchProducts()
        }
    }
}