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


    //사용 예정
    //var isUser: Bool
    
    //색상명 수정 필요
    static func randomProfileColor() -> String {
        let ProfileColor: [String] = [".pastelBlue", ".pastelYellow", ".pastelGreen"]
        return ProfileColor.filter { !$0.contains("blue") && !$0.contains("red") && !$0.contains("yellow") && !$0.contains("green") }.randomElement() ?? ".gray" // 기본값은 ".pastelRed"
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
