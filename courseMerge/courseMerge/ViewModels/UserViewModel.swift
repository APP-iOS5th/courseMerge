//
//  UserViewModel.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/11/24.
//

import Foundation
import FirebaseAuth

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var currentUserUID: String?
    
    init() {
        // Sample data for demonstration
        users = [
            User(username: "별빛여우", usercolor: "PastelRed", isHost: true),
            User(username: "달빛도깨비", usercolor: "PastelBlue", isHost: false),
            User(username: "개코원숭이", usercolor: "PastelGreen", isHost: false),
            User(username: "무지개코끼리", usercolor: "PastelYellow", isHost: false)
        ]
        
        // Fetch current user UID
        fetchCurrentUserUID()
    }
    
    func fetchCurrentUserUID() {
        if let uid = Auth.auth().currentUser?.uid {
            currentUserUID = uid
        } else {
            print("No current user logged in.")
        }
    }
    
    func identifySelfInParty(allMembers: [User]) {
        guard let currentUserUID = currentUserUID else {
            print("No current user logged in.")
            return
        }
        for member in allMembers {
            if member.uid == currentUserUID {
                print("This is you: \(member.username)")
            } else {
                print("Other member: \(member.username)")
            }
        }
    }
}