//
//  User.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/11/24.
//

import Foundation
import FirebaseAuth

struct User: Identifiable {
    let id: UUID = UUID()
    var uid: String? // Firebase UID
    var username: String
    var usercolor: String
    var isHost: Bool
}

extension User {
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

func identifySelfInParty(partyMembers: [User]) {
    guard let currentUserUID = Auth.auth().currentUser?.uid else {
        print("No current user logged in.")
        return
    }
    for member in partyMembers {
        if member.uid == currentUserUID {
            print("This is you: \(member.username)")
        } else {
            print("Other member: \(member.username)")
        }
    }
}
