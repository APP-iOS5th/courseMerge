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

struct User: Hashable {
    let id: UUID = UUID()
    var username: String
    var usercolor: String
    var isHost: Bool
    //사용 예정
    //var isUser: Bool
    
    //색상명 수정 필요
    static func randomProfileColor() -> String {
        let ProfileColor: [String] = [".pastelBlue", ".pastelYellow", ".pastelGreen"]
        return ProfileColor.filter { !$0.contains("blue") && !$0.contains("red") && !$0.contains("yellow") && !$0.contains("green") }.randomElement() ?? ".gray" // 기본값은 ".pastelRed"
    }
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
