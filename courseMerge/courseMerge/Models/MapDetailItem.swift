//
//  MapDetailItem.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/10/24.
//

import Foundation

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
