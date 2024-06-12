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
    @State private var isFirstCourse: Bool = true
    
    @State private var locationService = LocationService(completer: MKLocalSearchCompleter())
    @Binding var searchResults: [MapDetailItem]
    
    @State private var heights: Double = 0.7

    var body: some View {
        NavigationStack {
            VStack {
                searchBar
                categoryList
                if searchText.isEmpty {
                    recentVisitedView
                } else {
                    searchResultsView
                        .onChange(of: searchText) { _, newValue in
                            locationService.update(queryFragment: newValue)
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
        .presentationDetents([.medium, .fraction(self.heights)])
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
    

    
    // MARK: - SearchResultList
    var searchResultsView: some View {
        List {
            ForEach(locationService.completions) { completion in
                Button {
                    Task {
                        if let singleLocation = try? await locationService.search(with: "\(completion.name ?? "") \(completion.address ?? "")").first {
                            searchResults = [singleLocation]
                            print("searchResults: \(searchResults)")
                            dismiss()
//                            withAnimation {
//                                self.heights = 0.5
//                            }
                        }
                    }
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
                .onSubmit {
                    Task {
                        searchResults = (try? await locationService.search(with: searchText)) ?? []
                    }
                }
        }
        .modifier(TextFieldGrayBackgroundColor())
        .padding(.horizontal, 20)
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

//
//@Observable
//class LocationService: NSObject, MKLocalSearchCompleterDelegate {
//    private let completer: MKLocalSearchCompleter
//
//    var completions = [MapDetailItem]()
//
//    init(completer: MKLocalSearchCompleter) {
//        self.completer = completer
//        super.init()
//        self.completer.delegate = self
//    }
//
//    func update(queryFragment: String) {
//        completer.resultTypes = .address
//        completer.queryFragment = queryFragment
//    }
//
//    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
//        completions = completer.results.map { result in
//            
//            let mapItem = result.value(forKey: "_mapItem") as? MKMapItem
//            
//            return .init(
//                name: result.title,
//                address: result.subtitle,
//                phoneNumber: mapItem?.phoneNumber,
//                category: Category(rawValue: mapItem?.pointOfInterestCategory?.rawValue ?? ""),
//                // MKMapItem.pointOfInterestCategory 이건가? placemark?
//                location: mapItem?.placemark.coordinate
//            )
//        }
//    }
//}



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
        completer.resultTypes = .pointOfInterest
        completer.queryFragment = queryFragment
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let group = DispatchGroup()
        completions.removeAll()

        for result in completer.results {
            group.enter()
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = result.title

            let search = MKLocalSearch(request: searchRequest)
            search.start { response, error in
                if let item = response?.mapItems.first {
                    let mapDetailItem = MapDetailItem(
                        name: result.title,
                        address: result.subtitle,
                        phoneNumber: item.phoneNumber,
                        category: Category(rawValue: item.pointOfInterestCategory?.rawValue ?? ""),
                        location: item.placemark.coordinate
                    )
                    self.completions.append(mapDetailItem)
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            // 결과가 업데이트되었을 때, 필요하면 추가적인 작업을 여기에 추가
        }
    }

    func search(with query: String, coordinate: CLLocationCoordinate2D? = nil) async throws -> [MapDetailItem] {
        let mapKitRequest = MKLocalSearch.Request()
        mapKitRequest.naturalLanguageQuery = query
        mapKitRequest.resultTypes = .pointOfInterest
        if let coordinate {
            mapKitRequest.region = .init(.init(origin: .init(coordinate), size: .init(width: 1, height: 1)))
        }
        let search = MKLocalSearch(request: mapKitRequest)
        let response = try await search.start()

        return response.mapItems.compactMap { mapItem in
            guard let location = mapItem.placemark.location?.coordinate else { return nil }
            return MapDetailItem(
                name: mapItem.name,
                address: mapItem.placemark.title,
                phoneNumber: mapItem.phoneNumber,
                category: Category(rawValue: mapItem.pointOfInterestCategory?.rawValue ?? ""),
                location: location
            )
        }
    }
}
