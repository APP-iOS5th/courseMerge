//
//  MapView.swift
//  CourseMerge
//
//  Created by 황규상 on 6/10/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
            
            VStack {
                HeaderView()
                Spacer()
            }
            
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        print("현재위치버튼 클릭")
                    }) {
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
                }
            }
        }
    }
}

struct HeaderView: View {
    @State private var selectedDate = Date()
    @State private var isExpanded = false
    @State private var iconViewHeight: CGFloat = 0
    @State private var expanded = false
    @State private var showingActionSheet = false
    @State private var activatedPartyName: String = "제주도 파티"
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    self.showingActionSheet = true
                } label: {
                    HStack {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.white)
                        Text(activatedPartyName)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(width: 130, height: 34)
                    .font(.system(size: 15))
                    .background(Color.blue)
                    .cornerRadius(20)
                    .actionSheet(isPresented: $showingActionSheet) {
                        ActionSheet(
                            title: Text("파티를 선택해주세요"),
                            message: nil,
                            // TODO: 버튼 텍스트에 fontWeight 안들어감 ㅂㄷㅂㄷ
                            buttons: [
                                .default(Text("제주도 파티").fontWeight(.bold), action: {
                                    self.activatedPartyName = "제주도 파티"
                                }),
                                .default(Text("은평구 파티").fontWeight(.regular), action: {
                                    self.activatedPartyName = "은평구 파티"
                                }),
                                .default(Text("동두천 파티").fontWeight(.regular), action: {
                                    self.activatedPartyName = "동두천 파티"
                                }),
                                .cancel(Text("Cancel"))
                            ]
                        )
                    }
                }
                
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .labelsHidden()
                    .padding()
                    .frame(width: 124, height: 34)
                    .background(Color.clear)
                    .cornerRadius(10)
                
                Button {
                    // TODO: 검색화면 연결
                } label: {
                    Image(systemName: "magnifyingglass")
                        .padding()
                }
                .frame(width: 24.64, height: 22)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .frame(height: 48)
            
            Text("지도")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 52)
            
            Divider()
        }
        .padding(.horizontal)
        .background(Color.white)
        
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
                .padding(.top, -8)
                .background(Color.white.opacity(0.5))
            }
            
            Button {
                withAnimation(.easeInOut) {
                    expanded.toggle()
                }
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: expanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.black)
                        .padding(.bottom, 8)
                        .offset(y: 4)
                    Spacer()
                }
                .frame(height: 20)
                .background(Color.white.opacity(expanded ? 0.5 : 1))
            }
            .padding(.top, -8)
        }
    }
}

struct IconView: View {
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
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 40, height: 40)
                
                Image(systemName: "mappin.and.ellipse")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
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
                .font(.caption)
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

struct IconData {
    var color: Color
    var iconName: String
    var label: String
    var hasCrown: Bool
    var hasPerson: Bool
}

let iconData: [IconData] = [
    IconData(color: .black, iconName: "Main", label: "Main", hasCrown: false, hasPerson: false),
    IconData(color: .red, iconName: "별빛여우", label: "별빛여우", hasCrown: true, hasPerson: false),
    IconData(color: .orange, iconName: "달빛도깨비", label: "달빛도깨비", hasCrown: false, hasPerson: true),
    IconData(color: .yellow, iconName: "무지개코끼리", label: "무지개코끼리", hasCrown: false, hasPerson: false),
    IconData(color: .green, iconName: "개코원숭이", label: "개코원숭이", hasCrown: false, hasPerson: false),
    IconData(color: .purple, iconName: "악어모가지", label: "악어모가지", hasCrown: false, hasPerson: false),
    IconData(color: .brown, iconName: "기린발톱", label: "기린발톱", hasCrown: false, hasPerson: false)
]

#Preview {
    MapView()
}
