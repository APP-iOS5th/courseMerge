//
//  PartyDetailsViewModel.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/11/24.
//

import Foundation


// Parties CRUD, current Party
class PartyDetailsViewModel: ObservableObject {
    @Published var parties: [PartyDetail] = []
    @Published var currentParty: PartyDetail

    init() {
        self.parties = Self.loadExampleData()
        self.currentParty = Self.loadExampleSingleData()    // 변경 필요
    }
    
    private static func loadExampleSingleData() -> PartyDetail {
        PartyDetail(
            title: "제주도 파티",
            description: "이것은 매우 긴 설명입니다. iOS 앱스쿨 5기에서 우리는 파티를 즐기기 위해 제주도에 갑니다. 이 파티는 매우 특별하며, 다양한 활동과 이벤트가 계획되어 있습니다. 모든 멤버는 즐거운 시간을 보낼 것입니다. 이 설명은 예제 텍스트로서 매우 길게 작성되었습니다.",
            members: User.exampleUsers,
            startdate: Date(),
            enddate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        )
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
