//
//  PartyDetailsViewModel.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/11/24.
//

import Foundation

class PartyDetailsViewModel: ObservableObject {
    @Published var parties: [PartyDetail] = []

    init() {
        self.parties = Self.loadExampleData()
    }

    private static func loadExampleData() -> [PartyDetail] {
        return [
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
}
