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
        // parties 컬렉션과 users 컬렉션을 연동해야 합니다
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
}
