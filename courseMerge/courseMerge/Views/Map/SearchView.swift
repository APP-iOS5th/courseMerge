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
            VStack {
                categoryList
                
                List {
                    ForEach(filteredItems, id: \.self) { item in
                        Text(item)
                    }
                }
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
        ScrollView(.horizontal) {
            HStack {
                ForEach(0...5, id: \.self) { item in
                    HStack {
                        Label("카페", systemImage: "fork.knife.circle.fill")
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
