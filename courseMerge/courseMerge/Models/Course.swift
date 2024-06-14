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
    let child: MapDetailItem?
}

struct Route: Identifiable {
    let id = UUID()
    let points: [RoutePoint]
    let travelTime: TimeInterval
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
    static var example: Course {
        let user1 = User.exampleUsers[0]
        let user2 = User.exampleUsers[1]
        let user3 = User.exampleUsers[2]
        
        
        let parentLocation1 = MapDetailItem.recentVisitedExample[0]
        let parentLocation2 = MapDetailItem.recentVisitedExample[1]
        let parentLocation3 = MapDetailItem.recentVisitedExample[2]
        let parentLocation4 = MapDetailItem.recentVisitedExample[3]
        
        let childLocation1 = MapDetailItem.recentVisitedExample[4]
        let childLocation2 = MapDetailItem.recentVisitedExample[5]
        let childLocation3 = MapDetailItem.recentVisitedExample[6]
        let childLocation4 = MapDetailItem.recentVisitedExample[7]
        

        let line1 = RoutePoint(parent: parentLocation1, child: childLocation1)
        let line2 = RoutePoint(parent: parentLocation2, child: childLocation2)
        let line3 = RoutePoint(parent: parentLocation3, child: childLocation3)
        let line4 = RoutePoint(parent: parentLocation4, child: childLocation4)

        let firstDayRoute = Route(points: [line1, line2], travelTime: 1800)
        let SecondDayRoute = Route(points: [line3, line4], travelTime: 2000)
        
        return Course(user: user1, routes: [firstDayRoute, SecondDayRoute], party: PartyDetail.exampleParty, date: Date())
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
