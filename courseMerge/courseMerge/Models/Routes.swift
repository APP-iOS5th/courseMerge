//
//  Routes.swift
//  CourseMerge
//
//  Created by iyungui on 6/11/24.
//

import SwiftUI

// 특정 루트의 설명 (이전 장소와 다음 장소 포함)
struct Route {
    let startPoint: MapDetailItem
    let nextPoint: MapDetailItem
    let travelTime: TimeInterval // in seconds
//    let transportationMode: TransportationMode
}

// 여러 날의 루트를 담는 구조체
struct MultiDayRoute: Identifiable {
    let id = UUID()
    let user: User
    let date: Date
    let routes: [Route]
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

struct Routes {
    var multiDayRoutes: [MultiDayRoute]
    
    mutating func addRoute(_ multiDayRoute: MultiDayRoute) {
        multiDayRoutes.append(multiDayRoute)
    }
    
    mutating func removeRoute(at index: Int) {
        guard index >= 0 && index < multiDayRoutes.count else {
            print("Index out of range")
            return
        }
        multiDayRoutes.remove(at: index)
    }
    
    func getRoute(at index: Int) -> MultiDayRoute? {
        guard index >= 0 && index < multiDayRoutes.count else {
            print("Index out of range")
            return nil
        }
        return multiDayRoutes[index]
    }
}

//enum TransportationMode: String {
//    case walking
//    case driving
//    case cycling
//    case publicTransport
//}
