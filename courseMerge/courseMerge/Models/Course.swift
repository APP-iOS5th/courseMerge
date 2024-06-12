//
//  Course.swift
//  CourseMerge
//
//  Created by iyungui on 6/11/24.
//

import SwiftUI

// 특정 루트의 설명 (이전 장소와 다음 장소 포함)
struct Route {
    let startPoint: MapDetailItem
    let nextPoint: MapDetailItem
    let travelTime: TimeInterval
//    let transportationMode: TransportationMode
}

// 여러 날의 루트를 담는 구조체 - Course
struct Course: Identifiable {
    let id = UUID()
    let user: User
    let date: Date
    let routes: [Route] // 하루의 루트: Course.routes
    let party: PartyDetail
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}


// MARK: - example data

extension Course {
    static var example: [Course] {
        let user1 = User.exampleUsers[0]
        let user2 = User.exampleUsers[1]
        let user3 = User.exampleUsers[2]
        
        
        let startLocation1 = MapDetailItem.recentVisitedExample[0]
        let startLocation2 = MapDetailItem.recentVisitedExample[2]
        let nextLocation1 = MapDetailItem.recentVisitedExample[1]
        let nextLocation2 = MapDetailItem.recentVisitedExample[2]
        

        let route1 = Route(startPoint: startLocation1, nextPoint: nextLocation1, travelTime: 1800)
        let route2 = Route(startPoint: startLocation2, nextPoint: nextLocation2, travelTime: 1800)

        
        return [
            Course(user: user1, date: Date(), routes: [route1], party: PartyDetail.exampleParty),
            Course(user: user2, date: Date(), routes: [route2], party: PartyDetail.exampleParty),
            Course(user: user3, date: Date(), routes: [route1], party: PartyDetail.exampleParty)
        ]
    }
}




/*
 enum TransportationMode: String {
     case walking
     case driving
     case cycling
     case publicTransport
 }
 */
