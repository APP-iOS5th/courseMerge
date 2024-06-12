//
//  PartyDetail.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/10/24.
//

import Foundation

// 단일 파티 상세 정보 - 파티명, 파티 설명, 멤버 누구누구 있는지(호스트 여부 파악 가능). 기간
// 따로 Parties 를 만들 필요는 x

struct PartyDetail: Identifiable {
    let id: UUID = UUID()
    var title: String
    var description: String
    var members: [User]
    var startdate: Date
    var enddate: Date
}

extension PartyDetail {
    static var exampleParty: PartyDetail = PartyDetail(title: "제주도 파티", description: "iOS 앱스쿨 5기", members: User.exampleUsers, startdate: Date(), enddate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
    
    static var exampleParties: [PartyDetail] = [
        PartyDetail(
            title: "제주도 파티",
            description: "iOS 앱스쿨 5기",
            members: User.exampleUsers,
            startdate: Date(),
            enddate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        ),
        PartyDetail(
            title: "동두천 파티",
            description: "iOS 앱스쿨 5기",
            members: User.exampleUsers,
            startdate: Date(),
            enddate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        ),
        PartyDetail(
            title: "은평구 파티",
            description: "iOS 앱스쿨 5기",
            members: User.exampleUsers,
            startdate: Date(),
            enddate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        )
    ]
}


