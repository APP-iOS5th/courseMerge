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
    // 날짜를 원하는 형식으로 포맷하는 프로퍼티
    var formattedStartDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: self.startdate)
    }

    var formattedEndDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: self.enddate)
    }
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


