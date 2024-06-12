//
//  SearchView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/10/24.
//

import SwiftUI

// MARK: - SEARCH VIEW
struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State private var searchText: String = ""
    
    let categoryItems: [CategoryItem] = CategoryItem.categoryItems
    
    let recentVisited: [MapDetailItem] = MapDetailItem.recentVisitedExample
    
//  Focus State 추가
    
    @State private var isFirstCourse: Bool = true
    
    @State private var locationService = LocationService(completer: .init())

    var body: some View {
        NavigationStack {
            VStack {
                searchBar
                categoryList
                if searchText.isEmpty {
                    recentVisitedView
                } else {
                    searchResultsView
                        .onChange(of: searchText) {
                            locationService.update(queryFragment: searchText)
                        }
                }
            }
            .navigationTitle("장소 검색")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .background(colorScheme == .dark ? Color("BGSecondaryDarkElevated") : Color("BGSecondary"))
        }
        .interactiveDismissDisabled()
        .presentationDetents([.medium, .large])
        .presentationBackground(.regularMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
    }
    
    // MARK: - CategoryList
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
    
    // MARK: - RecentVisited
    var recentVisitedView: some View {
        // recent Visited
        List {
            Section {
                ForEach(recentVisited) { item in
                    NavigationLink(destination: SearchResultDetailView(item: item, isFirstCourse: $isFirstCourse, isEdit: .constant(false))) {
                        MapItemRow(item: item)
                        
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
    }
    
    // MARK: - SearchResultList
    var searchResultsView: some View {
        List {
            ForEach(locationService.completions) { completion in
                Button {
                    
                } label: {
                    MapItemRow(item: completion)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .scrollContentBackground(.hidden)
        .background(colorScheme == .dark ? Color("BGPrimaryDarkElevated") : .clear)
    }
    
    // MARK: - SearchBar
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("장소를 검색하세요.", text: $searchText)
                .autocorrectionDisabled()
        }
        .modifier(TextFieldGrayBackgroundColor())
        .padding(.horizontal, 20)
    }
}

struct TextFieldGrayBackgroundColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(.gray.opacity(0.1))
            .cornerRadius(8)
            .foregroundColor(.primary)
    }
}

#Preview {
    MapView()
}



import MapKit


@Observable
class LocationService: NSObject, MKLocalSearchCompleterDelegate {
    private let completer: MKLocalSearchCompleter

    var completions = [MapDetailItem]()

    init(completer: MKLocalSearchCompleter) {
        self.completer = completer
        super.init()
        self.completer.delegate = self
    }

    func update(queryFragment: String) {
        completer.resultTypes = .address
        completer.queryFragment = queryFragment
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completions = completer.results.map { result in
            
            let mapItem = result.value(forKey: "_mapItem") as? MKMapItem
            
            return .init(
                name: result.title,
                address: result.subtitle,
                phoneNumber: mapItem?.phoneNumber,
                category: Category(rawValue: mapItem?.pointOfInterestCategory?.rawValue ?? ""),
                // MKMapItem.pointOfInterestCategory 이건가? placemark?
                location: mapItem?.placemark.coordinate
            )
        }
    }
}
