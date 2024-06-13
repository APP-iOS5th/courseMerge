//
//  UserViewModel.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/11/24.
//

import Foundation
import FirebaseAuth

// UserViewModel 의 역할: 자기 자신이 맞는지 확인하는 역할. 파티원삭제는 -> 파티 뷰 모델에서 관리

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var currentUser: User? = nil
    @Published var currentUserUID: String?
    
    init() {
        /* example data road
         self.users = User.exampleUsers
         */
        
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
