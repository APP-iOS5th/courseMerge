//
//  GroupPartyItem.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/10/24.
//

import Foundation

struct GroupPartyInfo: Identifiable {
    let id: UUID = UUID()
    var title: String
    var description: String
    var members: [User]
    var startdate: Date
    var enddate: Date
}

struct User {
    let id: UUID = UUID()
    var username: String
    var usercolor: String
    var isHost: Bool
}

extension GroupPartyInfo {
    static var exampleParties: [GroupPartyInfo] = [
        GroupPartyInfo(
            title: "제주도 파티",
            description: "iOS 앱스쿨 5기",
            members: [
                User(username: "황규상", usercolor: "PastelRed", isHost: true),
                User(username: "이융의", usercolor: "PastelBlue", isHost: false),
                User(username: "정희지", usercolor: "PastelGreen", isHost: false),
                User(username: "조현기", usercolor: "PastelYellow", isHost: false)
            ],
            startdate: Date(),
            enddate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        ),
        GroupPartyInfo(
            title: "동두천 파티",
            description: "iOS 앱스쿨 5기",
            members: [
                User(username: "이융의", usercolor: "PastelRed", isHost: false),
                User(username: "황규상", usercolor: "PastelBlue", isHost: false),
                User(username: "정희지", usercolor: "PastelGreen", isHost: false),
                User(username: "조현기", usercolor: "PastelYellow", isHost: false)
            ],
            startdate: Date(),
            enddate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        ),
        GroupPartyInfo(
            title: "은평구 파티",
            description: "iOS 앱스쿨 5기",
            members: [
                User(username: "정희지", usercolor: "PastelRed", isHost: false),
                User(username: "이융의", usercolor: "PastelBlue", isHost: false),
                User(username: "황규상", usercolor: "PastelGreen", isHost: false),
                User(username: "조현기", usercolor: "PastelYellow", isHost: false)
            ],
            startdate: Date(),
            enddate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        )
    ]
}
