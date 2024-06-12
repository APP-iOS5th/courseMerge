//
//  PracticeMapView.swift
//  CourseMerge
//
//  Created by iyungui on 6/11/24.
//

import SwiftUI
import MapKit

struct PracticeMapView: View {
    @State private var selectedTag: Int = 2
    
    var body: some View {
        Map {
            Marker("엠파이어 빌딩", systemImage: "star.fill", coordinate: .empireStateBuilding)
                .tint(.orange)
                .tag(1)
            
            Annotation("Columbia University", coordinate: .columbiaUniversity) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(selectedTag == 2 ? .red : .teal)
                    Text("🎓")
                        .padding(5)
                }
            }
            .tag(2)
        }
        .mapStyle(.standard)
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
    }
}

//struct PracticeMapViewTwo: View {
//    var body: some View {
//        Map {
////            MapCircle(center: .empireStateBuilding, radius: CLLocationDistance(250))
////                .foregroundStyle(.orange.opacity(0.7))
////                .mapOverlayLevel(level: .aboveLabels)
////            
////            MapCircle(center: .columbiaUniversity, radius: CLLocationDistance(350))
////                .foregroundStyle(.teal.opacity(0.60))
////                .mapOverlayLevel(level: .aboveRoads)
//            
//            MapPolygon(coordinates: [.empireStateBuilding, .empireStateBuilding])
//                .foregroundStyle(.orange.opacity(0.7))
//        }
//    }
//}

//struct RouteViewPractice: View {
//    let exampleRoute: Course = Course.example.first!
//    
//    @State private var route: MKRoute?
//    @State private var travelTime: String?
//    private let gradient = LinearGradient(colors: [.red, .orange], startPoint: .leading, endPoint: .trailing)
//    private let stroke = StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, dash: [8, 8])
//    
//    var body: some View {
//        Map {
//            if let route {
//                MapPolyline(route.polyline)
//                    .stroke(.pastelRed, lineWidth: 10)
//                
//                Marker("startLocation1", systemImage: "", coordinate: exampleRoute.routes[0].startPoint.location ?? .empireStateBuilding)
//                
//                Marker(coordinate: exampleRoute.routes[0].nextPoint.location ?? .columbiaUniversity) {
//                    Image(systemName: "mappin.circle.fill")
//                        .foregroundStyle(Color(exampleRoute.user.usercolor))
//                }
//                
//                
//            }
//        }
//        .overlay(alignment: .bottom) {
//            if let travelTime {
//                Text("Travel time: \(travelTime)")
//                    .padding()
//                    .font(.headline)
//                    .foregroundStyle(.black)
//                    .background(.ultraThinMaterial)
//                    .cornerRadius(15)
//            }
//        }
//        .onAppear {
//            fetchRouteFrom(exampleRoute.routes[0].startPoint.location ?? .empireStateBuilding, to: exampleRoute.routes[0].nextPoint.location ?? .columbiaUniversity)
//        }
//    }
//}
//
//extension RouteViewPractice {
//    private func fetchRouteFrom(_ source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
//        let request = MKDirections.Request()
//        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source))
//        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
//        request.transportType = .automobile
//        
//        Task {
//            let result = try? await MKDirections(request: request).calculate()
//            route = result?.routes.first
////            getTravelTime()
//        }
//    }
//}

struct LocationPreviewLookAroundView: View {
    @State private var lookAroundScene: MKLookAroundScene?
    var selectedResult: MyFavoriteLocation
    
    var body: some View {
        LookAroundPreview(initialScene: lookAroundScene)
            .overlay(alignment: .bottomTrailing) {
                HStack {
                    Text("\(selectedResult.name)")
                }
                .font(.caption)
                .foregroundStyle(.white)
                .padding(18)
            }
            .onAppear {
                getLookAroundScene()
            }
            .onChange(of: selectedResult) {
                getLookAroundScene()
            }
    }
    
    func getLookAroundScene() {
        lookAroundScene = nil
        Task {
            let request = MKLookAroundSceneRequest(coordinate: selectedResult.coordinate)
            lookAroundScene = try? await request.scene
        }
    }
}

struct LocationPreviewView: View {
    @State private var selection: UUID?
    
    let myFavoriteLocations = [
        MyFavoriteLocation(name: "Empire state building", coordinate: .empireStateBuilding),
        MyFavoriteLocation(name: "Columbia University", coordinate: .columbiaUniversity),
        MyFavoriteLocation(name: "Weequahic Park", coordinate: .weequahicPark)
        ]
    
    var body: some View {
        Map(selection: $selection) {
            ForEach(myFavoriteLocations) { location in
                Marker(location.name, coordinate: location.coordinate)
                    .tint(.orange)
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                VStack(spacing: 0) {
                    if let selection {
                        if let item = myFavoriteLocations.first(where: { $0.id == selection }) {
                            LocationPreviewLookAroundView(selectedResult: item)
                                .frame(height: 128)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding([.top, .horizontal])
                        }
                    }
                }
                Spacer()
            }
            .background(.thinMaterial)
        }
        .onChange(of: selection) {
            guard let selection else { return }
            guard let item = myFavoriteLocations.first(where: { $0.id == selection }) else { return }
            print(item.coordinate)
        }
    }
}

struct MyFavoriteLocation: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
    static func == (lhs: MyFavoriteLocation, rhs: MyFavoriteLocation) -> Bool {
        return lhs.id == rhs.id
    }
}

//#Preview {
//    RouteViewPractice()
//    
//}


extension CLLocationCoordinate2D {
    static let weequahicPark = CLLocationCoordinate2D(latitude: 40.7063, longitude: -74.1973)
    static let empireStateBuilding = CLLocationCoordinate2D(latitude: 40.7484, longitude: -73.9857)
    static let columbiaUniversity = CLLocationCoordinate2D(latitude: 40.8075, longitude: -73.9626)
}


//struct testMapView: View {
//    @State private var isShowSearchViewModal: Bool = false
//    
//    // result detail view fraction
//    let heights = stride(from: 0.5, through: 0.75, by: 0.1).map { PresentationDetent.fraction($0) }
//    @State private var isShowDetailViewModal: Bool = false
//    
//    @State private var isFirstCourse: Bool = false
//    
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 20) {
//                
//                Button {
//                    isShowSearchViewModal = true
//                } label: {
//                    Image(systemName: "magnifyingglass")
//                        .font(.title)
//                }
//                
//                Button {
//                    isShowDetailViewModal = true
//                } label: {
//                    Image(systemName: "doc.text")
//                        .font(.title)
//                }
//                
//                NavigationLink(destination: UpdateCourseView()) {
//                    Image(systemName: "arrowshape.right.fill")
//                        .font(.title)
//                }
//                
//            }
//            .sheet(isPresented: $isShowSearchViewModal) {
//                SearchView()
//            }
//            .sheet(isPresented: $isShowDetailViewModal) {
//                SearchResultDetailView(item: MapDetailItem.recentVisitedExample.first!, isFirstCourse: $isFirstCourse, isEdit: .constant(false))
////                                .presentationDetents([.fraction(0.6), .fraction(0.75)])
//                    .presentationDetents(isFirstCourse ? [.fraction(0.65), .fraction(0.8)] : [.fraction(0.6), .fraction(0.75)])
//                //                .presentationDetents(Set(heights))
//                    .presentationDragIndicator(.visible)
//            }
//        }
//    }
//}
