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
    
    static let  ProfileColor: [String] = ["PastelBlue", "PastelYellow", "PastelGreen"]
    
    static let hexColors = [
        "#FF6347", // Tomato
        "#FFD700", // Gold
        "#20B2AA", // LightSeaGreen
        "#9400D3", // DarkViolet
        "#00FFFF", // Cyan
        "#ADFF2F", // GreenYellow
        "#4682B4", // SteelBlue
        "#FF69B4", // HotPink
        "#CD5C5C", // IndianRed
        "#808000", // Olive
        "#4169E1", // RoyalBlue
        "#FFA07A", // LightSalmon
        "#00FF7F", // SpringGreen
        "#8A2BE2", // BlueViolet
        "#F08080", // LightCoral
        "#32CD32", // LimeGreen
        "#20B2AA", // LightSeaGreen (중복 추가)
        "#8B008B", // DarkMagenta
        "#00FF00", // Lime
        "#FF4500", // OrangeRed
        "#1E90FF", // DodgerBlue
        "#FF1493"  // DeepPink
    ]
    
    static func randomColor() -> String {
        let combinedColors = ProfileColor + hexColors
        let uniqueColors = Array(Set(combinedColors))
        
        if let randomColor = uniqueColors.randomElement() {
            if ProfileColor.contains(randomColor) {
                return randomColor
            } else {
                return randomColor
            }
        } else {
            return "Gray" // 기본값은 회색
        }
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
