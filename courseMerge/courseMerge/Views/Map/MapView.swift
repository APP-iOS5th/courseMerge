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
                        .environmentObject(authViewModel)
                        
                    Spacer()
                }
                
                CurrentLocationAndUpdateCourseButton(locationManager: locationManager, cameraPosition: $position)
                    .environmentObject(partiesViewModel)
                    .environmentObject(authViewModel)
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
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack {
            HStack {
                PartySelectionButton()
                    .environmentObject(authViewModel)
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
            .environmentObject(partiesViewModel)
            .environmentObject(authViewModel)
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
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel

    var body: some View {
        VStack {
            if expanded {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {                          
                            if let currentParty = partiesViewModel.currentParty {
                                ForEach(currentParty.members) { user in
                                    Button(action: {
                                        print("seleted user: \(user.username)")
                                    }) {
                                        ProfileView(user: user, width: 75, height: 75, overlayWidth: 30, overlayHeight: 40, isUsername: true)
                                            .environmentObject(authViewModel)
                                    }
                                    .padding(.horizontal, 8)
                                }
                            } else {
                                
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
    
    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel
    @EnvironmentObject var authViewModel: AuthViewModel

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
                
                if authViewModel.isSignedIn {
                    NavigationLink(
                        destination: UpdateCourseView()
                            .environmentObject(partiesViewModel)
                            .environmentObject(authViewModel)) 
                    {
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


#Preview {
    MapView()
}

