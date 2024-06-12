//
//  MapDetailItem.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/10/24.
//

import Foundation
import SwiftUI
import MapKit

// 특정 장소의 상세 정보
struct MapDetailItem: Identifiable {
    let id = UUID()
    let name: String?
    let address: String?
    let phoneNumber: String?
    let category: Category?
    let location: CLLocationCoordinate2D?
}

extension MapDetailItem {
    static var recentVisitedExample: [MapDetailItem] = [
        MapDetailItem(name: "니시무라멘", address: "서울특별시 연남동 249-1", phoneNumber: "010-1234-5678", category: .restaurant, location: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780)),
        MapDetailItem(name: "유나드마이요거트", address: "서울특별시 강남구 123-1", phoneNumber: "010-1234-5678", category: .cafe, location: CLLocationCoordinate2D(latitude: 37.4980, longitude: 127.0276)),
        MapDetailItem(name: "오츠커피", address: "서울특별시 종로구 456-2", phoneNumber: "010-1234-5678", category: .cafe, location: CLLocationCoordinate2D(latitude: 37.5700, longitude: 126.9835)),
        MapDetailItem(name: "그믐족발", address: "서울특별시 동작구 789-3", phoneNumber: nil, category: .restaurant, location: CLLocationCoordinate2D(latitude: 37.5120, longitude: 126.9396)),
        MapDetailItem(name: "궁둥공원", address: "서울특별시 마포구 101-4", phoneNumber: nil, category: .park, location: CLLocationCoordinate2D(latitude: 37.5520, longitude: 126.9346)),
    ]
}


// 특정 하루 코스의 설명
struct CourseDescription: Identifiable {
    let id = UUID()
    let description: String
    let date: Date
    let items: [MapDetailItem]
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

extension CourseDescription {
    static var example: [CourseDescription] = [
        CourseDescription(description: "연남동 코스 끝내기", date: Date(timeIntervalSince1970: 1719910800), items: MapDetailItem.recentVisitedExample),
        CourseDescription(description: "오늘은 성수도", date: Date(timeIntervalSince1970: 1719997200), items: MapDetailItem.recentVisitedExample),
        CourseDescription(description: "이제 어디갈까", date: Date(timeIntervalSince1970: 1720083600), items: MapDetailItem.recentVisitedExample)
    ]
}
