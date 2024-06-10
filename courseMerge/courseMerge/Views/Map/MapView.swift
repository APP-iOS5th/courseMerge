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
                .ignoresSafeArea(edges: .all)
            
            VStack {
                HeaderView()
                Spacer()
            }
        }
    }
}

struct HeaderView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    print("제주도 파티 버튼 클릭됨")
                } label: {
                    HStack {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.white)
                        Text("제주도 파티")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(width: 130, height: 34) // Figma 에서 124로 설정했는데 너무 작아서 수정함.
                    .font(.system(size: 15))
                    .background(Color.blue)
                    .cornerRadius(20)
                }
                
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .labelsHidden()
                    .padding()
                    .frame(width: 124, height: 34)
                    .background(Color.clear)
                    .cornerRadius(10)
                
                Button {
                    print("sss")
                } label: {
                    Image(systemName: "magnifyingglass")
                        .padding()
                }
                .frame(width: 24.64, height: 22)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .frame(height: 48)
            
            Text("지도2")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 52)
        }
        .padding()
        .background(Color.white)
    }
}

#Preview {
    MapView()
}
