//
//  SearchView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/10/24.
//

import SwiftUI

struct testMapView: View {
    @State private var isShowModal: Bool = false
    
    var body: some View {
        VStack {
            Button {
                isShowModal = true
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title)
            }
        }
        .sheet(isPresented: $isShowModal) {
            SearchView()
        }
    }
}

struct Category {
    let symbol: String?
    let customImage: Image?
    let context: String
}

extension Category {
    static var categoryItems: [Category] = [
        Category(symbol: nil, customImage: Image("custom.cup.and.saucer.circle.fill"), context: "카페"),
        Category(symbol: "fork.knife.circle.fill", customImage: nil, context: "식당"),
        Category(symbol: "storefront.circle.fill", customImage: nil, context: "편의점"),
        Category(symbol: "parkingsign.circle.fill", customImage: nil, context: "주차장"),
        Category(symbol: "cart.circle.fill", customImage: nil, context: "마트"),
    ]
}

struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText: String = ""
    
    let items = Array(0...10).map { "Item \($0)" }
    let categoryItems: [Category] = Category.categoryItems

    var filteredItems: [String] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                categoryList
                List {
                    Section {
                        ForEach(filteredItems, id: \.self) { item in
                            Text(item)
                        }
                    } header: {
                        Text("최근 검색한 장소")
//                            .font(.footnote)
//                            .foregroundStyle(Color("LabelsSecondary"))
                    }
                    
                }
                .listStyle(GroupedListStyle())
                .scrollContentBackground(.hidden)
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .navigationTitle("장소 검색")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
            }
            .background(Color("BGSecondary"))
        }
    }
    
    var categoryList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(Category.categoryItems, id: \.context) { category in
                    HStack {
                        if let symbol = category.symbol {
                            Image(systemName: symbol)
                                .foregroundStyle(Color.blue)
                                .font(.title2)
                        } else if let customImage = category.customImage {
                            customImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                        }
                        Text(category.context)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(Color.white)
                    .cornerRadius(4)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    SearchView()
}
