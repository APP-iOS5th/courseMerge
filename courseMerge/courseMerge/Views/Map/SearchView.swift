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
    @State private var isShowDetailViewModal: Bool = false
    
    @State private var isFirstCourse: Bool = false
    
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
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
                
                NavigationLink(destination: UpdateCourseView()) {
                    Image(systemName: "arrowshape.right.fill")
                        .font(.title)
                }
                
            }
            .sheet(isPresented: $isShowSearchViewModal) {
                SearchView()
            }
            .sheet(isPresented: $isShowDetailViewModal) {
                SearchResultDetailView(item: MapDetailItem.recentVisitedExample.first!, isFirstCourse: $isFirstCourse, isEdit: .constant(false))
//                                .presentationDetents([.fraction(0.6), .fraction(0.75)])
                    .presentationDetents(isFirstCourse ? [.fraction(0.65), .fraction(0.8)] : [.fraction(0.6), .fraction(0.75)])
                //                .presentationDetents(Set(heights))
                    .presentationDragIndicator(.visible)
            }
        }
    }
}


struct ItemRow: View {
    let item: MapDetailItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name ?? "No Name")
                    .font(.body)
                Text(item.address ?? "No address")
                    .font(.subheadline)
                    .foregroundStyle(Color("LabelsSecondary"))
            }
            
            Spacer()
            
            Text(item.category?.rawValue ?? "No Category")
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
    @Environment(\.colorScheme) var colorScheme
    
    @State private var searchText: String = ""
    
    let categoryItems: [CategoryItem] = CategoryItem.categoryItems
    
    let recentVisited: [MapDetailItem] = MapDetailItem.recentVisitedExample
    
    // TODO: Focus State 추가
    
    @State private var isFirstCourse: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack {
                categoryList
                
                // recent Visited
                List {
                    Section {
                        ForEach(recentVisited) { item in
                            NavigationLink(destination: SearchResultDetailView(item: item, isFirstCourse: $isFirstCourse, isEdit: .constant(false))) {
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
                .background(colorScheme == .dark ? Color("BGPrimaryDarkElevated") : .clear)
                
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
            .background(colorScheme == .dark ? Color("BGSecondaryDarkElevated") : Color("BGSecondary"))
        }
    }
    
    var categoryList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(CategoryItem.categoryItems, id: \.context) { category in
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
                    .background(Color("FillTertiary"))
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
