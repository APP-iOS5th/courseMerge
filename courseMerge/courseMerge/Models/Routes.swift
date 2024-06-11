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
    let travelTime: TimeInterval // in seconds -- 일단 추가
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


// MARK: - example data

extension MultiDayRoute {
    static var example: [MultiDayRoute] {
        let user1 = User(username: "훈이", usercolor: "gray", isHost: false)
        let user2 = User(username: "철수", usercolor: "blue", isHost: false)
        let user3 = User(username: "짱구", usercolor: "red", isHost: false)
        
        
        let startLocation1 = MapDetailItem.recentVisitedExample[0]
        let startLocation2 = MapDetailItem.recentVisitedExample[2]
        let nextLocation1 = MapDetailItem.recentVisitedExample[1]
        let nextLocation2 = MapDetailItem.recentVisitedExample[2]
        

        let route1 = Route(startPoint: startLocation1, nextPoint: nextLocation1, travelTime: 1800)
        let route2 = Route(startPoint: startLocation2, nextPoint: nextLocation2, travelTime: 1800)

        
        return [
            MultiDayRoute(user: user1, date: Date(), routes: [route1]),
            MultiDayRoute(user: user2, date: Date(), routes: [route2]),
            MultiDayRoute(user: user3, date: Date(), routes: [route1])
        ]
    }
}
