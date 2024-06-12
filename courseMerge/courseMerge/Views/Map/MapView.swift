//
//  MapView.swift
//  CourseMerge
//
//  Created by 황규상 on 6/10/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.9033, longitude: 127.0606),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var activatedPartyName: String = "제주도 파티"
    @State private var isShowAlert: Bool = true
    
    
    @State private var position = MapCameraPosition.automatic
    @State private var searchResults = [MapDetailItem]()
    @State private var selectedLocation: MapDetailItem?

    // viewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Map(position: $position, selection: $selectedLocation) {
                    ForEach(searchResults) { result in
                        if let location = result.location {
                            Marker(coordinate: location) {
                                Image(systemName: "mappin")
                            }
                            .tag(result)
                        }
                    }
                }
                .ignoresSafeArea()
                /*
                                    .onAppear {
                        locationManager.requestLocation()
                    }
                    */
                
                VStack {
                    HeaderView(activatedPartyName: $activatedPartyName, searchResults: $searchResults)
                        .environmentObject(partiesViewModel)
                    Spacer()
                }
                
                CurrentLocationAndUpdateCourseButton(locationManager: locationManager, cameraPosition: $position)
            }
            .onAppear {
                if activatedPartyName.isEmpty {
                    isShowAlert = true
                } else {
                    isShowAlert = false
                }
            }
            .alert(isPresented: $isShowAlert) {
                Alert(
                    title: Text("알림"),
                    message: Text("현재 참여중인 파티가 없습니다.\n파티를 추가하시겠어요?"),
                    primaryButton: .default(Text("추가")) {
                        isShowAlert = false
                    },
                    secondaryButton: .cancel(Text("지금 안해요"))
                )
            }
        }
    }
}

struct HeaderView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isShowSearchViewModal: Bool = false
    @Binding var activatedPartyName: String
    @Binding var searchResults: [MapDetailItem]
    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel
    
    var body: some View {
        VStack {
            HStack {
                PartySelectionButton()
                    .environmentObject(partiesViewModel)

                PartyDateSelectionPicker()
                    .environmentObject(partiesViewModel)
                
                PlaceSearchButton(isShowSearchViewModal: $isShowSearchViewModal)
                    .environmentObject(partiesViewModel)

            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .frame(height: 48)
            
            viewTitleText()
        }
        .sheet(isPresented: $isShowSearchViewModal) {
            SearchView(searchResults: $searchResults)
        }
        .padding(.horizontal)
        .background(colorScheme == .dark ? Color("BGPrimaryDarkBase") : Color("BGPrimary"))
        
        MemberCustomDisclosureGroup()
    }
        
}



/// 파티 구성 기간 중 특정 날짜에 대한 구성원들의 코스를 볼 수 있게 날짜를 선택하는 피커
struct PartyDateSelectionPicker: View {
    @State private var selectedDate = Date()
    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel

    var body: some View {
        DatePicker("", selection: $selectedDate, displayedComponents: .date)
            .datePickerStyle(CompactDatePickerStyle())
            .labelsHidden()
            .padding()
            .frame(width: 124, height: 34)
            .background(Color.clear)
            .cornerRadius(10)
    }
}

/// 장소검색버튼
struct PlaceSearchButton: View {
    @Binding var isShowSearchViewModal: Bool
    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel

    var body: some View {
        Button {
            isShowSearchViewModal = true
        } label: {
            Image(systemName: "magnifyingglass")
                .padding()
        }
        .frame(width: 24.64, height: 22)
    }
}

/// 선택된 파티에 따라 구성원을 보여주는 Custom DisclosureGroup
struct MemberCustomDisclosureGroup: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var expanded = false
    @State private var iconViewHeight: CGFloat = 0
    
    var body: some View {
        VStack {
            if expanded {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {                          
                            
                            ForEach(1...iconData.count, id: \.self) { index in
                                Button(action: {
                                    print("\(iconData[index-1].label) 버튼 클릭")
                                }) {
                                    IconView(
                                        color: iconData[index-1].color,
                                        iconName: iconData[index-1].iconName,
                                        label: iconData[index-1].label,
                                        hasCrown: iconData[index-1].hasCrown,
                                        hasPerson: iconData[index-1].hasPerson,
                                        iconViewHeight: $iconViewHeight
                                    )
                                }
                                .padding(.horizontal, 8)
                            }
                        }
                    }
                }
                .padding()
                .background(colorScheme == .dark ? Color("BGPrimaryDarkBase").opacity(expanded ? 0.8 : 1) : Color("BGPrimary").opacity(expanded ? 0.8 : 1))
                //.background(Color.white.opacity(0.8))
                .padding(.top, -8)
            }
            
            Button {
                withAnimation(.easeInOut) {
                    expanded.toggle()
                }
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: expanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(colorScheme == .dark ? Color("BGTertiaryDarkElevated") : Color("BGPrimaryDarkBase") ) //색상명 수정 필요
                        .padding(.bottom, 8)
                        .offset(y: 4)
                    Spacer()
                }
                .frame(height: 20)
                .background(colorScheme == .dark ? Color("BGPrimaryDarkBase").opacity(expanded ? 0.8 : 1) : Color("BGPrimary").opacity(expanded ? 0.8 : 1))
//                .background(Color.white.opacity(expanded ? 0.8 : 1))
            }
            .padding(.top, -8)
        }
    }
}

/// 현재위치 버튼, 코스변경 버튼
struct CurrentLocationAndUpdateCourseButton: View {
    @ObservedObject var locationManager: LocationManager
    @Binding var cameraPosition: MapCameraPosition

    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Button {
                    cameraPosition = .userLocation(
                        followsHeading: false,
                        fallback: .region(MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 37.9033, longitude: 127.0606),
                            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                        ))
                    )
                } label: {
                    Image(systemName: "location.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
                .padding(.bottom, 50)
                .padding(.leading, 20)
                
                Spacer()
                
                NavigationLink(destination: UpdateCourseView()) {
                    Text("코스변경하기")
                        .foregroundColor(.white)
                        .frame(width: 132, height: 50)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .font(.system(size: 17))
                }
                .padding(.bottom, 50)
                .padding(.trailing, 20)
            }
        }
    }
}


/// 해당 화면의 title text
struct viewTitleText: View {
    var body: some View {
        Text("지도")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 52)
        Divider()
    }
}



struct IconView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var color: Color
    var iconName: String
    var label: String
    var hasCrown: Bool = false
    var hasPerson: Bool = false
    @Binding var iconViewHeight: CGFloat
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: 70, height: 70)
                
                Image("ProfileMark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(color)
                
                if hasCrown {
                    Image(systemName: "crown.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .background(Color.yellow)
                        .clipShape(Circle())
                        .offset(x: 20, y: 20)
                }
                
                if hasPerson {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .offset(x: 20, y: 20)
                }
            }
            
            Text(label)
                .font(.system(size: 11))
                .foregroundStyle(.labelsPrimary)
        }
        .background(
            GeometryReader { geometry in
                Color.clear.onAppear {
                    self.iconViewHeight = geometry.size.height
                }
            }
        )
    }
}

#Preview {
    MapView()
}

