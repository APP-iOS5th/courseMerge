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

struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText: String = ""
    
    let items = Array(0...10).map { "Item \($0)" }

    var filteredItems: [String] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredItems, id: \.self) { item in
                    Text(item)
                }
            }
            .searchable(text: $searchText)
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
    }
}

#Preview {
    SearchView()
}
