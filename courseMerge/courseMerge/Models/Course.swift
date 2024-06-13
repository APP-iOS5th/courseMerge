//
//  Course.swift
//  CourseMerge
//
//  Created by iyungui on 6/11/24.
//

import SwiftUI

// 특정 루트의 설명 (이전 장소와 다음 장소 포함)

struct RoutePoint: Identifiable {
    let id = UUID()
    let parent: MapDetailItem?
    let child: MapDetailItem
}

struct Route: Identifiable {
    let id = UUID()
    let points: [RoutePoint]
    let travelTime: TimeInterval
    let user: User // 이 루트를 따르는 사용자
}


// 여러 날의 루트를 담는 구조체 - Course
struct Course: Identifiable {
    let id = UUID()
    let user: User
    let routes: [Route] // 여러 날의 루트
    let party: PartyDetail
    var date: Date
    
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
