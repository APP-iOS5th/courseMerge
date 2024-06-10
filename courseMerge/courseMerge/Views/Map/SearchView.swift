//
//  SearchView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/10/24.
//

import SwiftUI

struct testMapView: View {
    @State private var isShowSearchViewModal: Bool = false
    
    // result detail view fraction
    let heights = stride(from: 0.5, through: 0.75, by: 0.1).map { PresentationDetent.fraction($0) }
    @State private var isShowDetailViewModal: Bool = true
    var body: some View {
        VStack {
            Button {
                isShowSearchViewModal = true
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title)
            }
            Button {
                isShowDetailViewModal = true
            } label: {
                Image(systemName: "doc.text")
                    .font(.title)
            }
        }
        .sheet(isPresented: $isShowSearchViewModal) {
            SearchView()
        }
        .sheet(isPresented: $isShowDetailViewModal) {
            SearchResultDetailView()
                .presentationDetents([.medium, .fraction(0.75)])
//                .presentationDetents(Set(heights))
                .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - SearchResultDetailView

struct SearchResultDetailView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SearchResultDetailView()
}



struct MapDetailItem: Identifiable {
    let id = UUID()
    let name: String
    let address: String
}


// MARK: - ItemRow - recent visited place
extension MapDetailItem {
    static var recentVisitedExample: [MapDetailItem] = [
        MapDetailItem(name: "니시무라멘", address: "서울특별시 연남동 249-1"),
        MapDetailItem(name: "유나드 마이 요거트", address: "서울특별시 연남동 249-2"),
        MapDetailItem(name: "오츠 커피", address: "서울특별시 연남동 249-3"),
        MapDetailItem(name: "그믐족발", address: "서울특별시 연남동 249-4"),
        MapDetailItem(name: "궁둥공원", address: "서울특별시 연남동 249-5"),
    ]
}

struct ItemRow: View {
    let item: MapDetailItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name)
                .font(.body)
            Text(item.address)
                .font(.subheadline)
                .foregroundStyle(Color("LabelsSecondary"))
        }
    }
}

#Preview {
    ItemRow(item: MapDetailItem.recentVisitedExample.first!)
}


// MARK: - SearchView

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
    
    var recentVisited: [MapDetailItem] = MapDetailItem.recentVisitedExample
    // TODO: Focus State 추가
    
    var body: some View {
        NavigationStack {
            VStack {
                categoryList
                List {
                    Section {
                        ForEach(recentVisited) { item in
                            NavigationLink(destination: SearchResultDetailView()) {
                                ItemRow(item: item)
                                
                            }
                            
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                
                            } label: {
                                Label("삭제", systemImage: "trash")
                            }
                        }
                    } header: {
                        Text("최근 검색한 장소")
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
    testMapView()
}
