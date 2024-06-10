//
//  MapDetailItem.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/10/24.
//

import Foundation

struct CourseDescription: Identifiable {
    let id = UUID()
    let description: String
    let date: Date
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

extension CourseDescription {
    static var example: [CourseDescription] = [
        CourseDescription(description: "연남동 코스 끝내기", date: Date(timeIntervalSince1970: 1719910800)), // Example date: 2024-06-01
        CourseDescription(description: "오늘은 성수도", date: Date(timeIntervalSince1970: 1719997200)),
        CourseDescription(description: "이제 어디갈까", date: Date(timeIntervalSince1970: 1720083600))
    ]
}


struct MapDetailItem: Identifiable {
    let id = UUID()
    let name: String?
    let address: String?
    let phoneNumber: String?
    let category: Category?
    
}

// MARK: - ItemRow - recent visited place
extension MapDetailItem {
    static var recentVisitedExample: [MapDetailItem] = [
        MapDetailItem(name: "니시무라멘", address: "서울특별시 연남동 249-1", phoneNumber: "010-1234-5678", category: .restaurant),
        MapDetailItem(name: "유나드마이요거트", address: "서울특별시 연남동 249-2", phoneNumber: "010-1234-5678", category: .cafe),
        MapDetailItem(name: "오츠커피", address: "서울특별시 연남동 249-3", phoneNumber: "010-1234-5678", category: .cafe),
        MapDetailItem(name: "그믐족발", address: "서울특별시 연남동 249-4", phoneNumber: nil, category: .restaurant),
        MapDetailItem(name: "궁둥공원", address: "서울특별시 연남동 249-5", phoneNumber: nil, category: .park),
    ]
}
