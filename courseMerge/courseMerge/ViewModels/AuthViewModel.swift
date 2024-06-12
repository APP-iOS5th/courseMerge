//
//  AuthViewModel.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/11/24.
//

import Foundation
import FirebaseCore
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isSignedIn: Bool = false
    
    func checkSignInStatus() {
        self.isSignedIn = Auth.auth().currentUser != nil
    }
    
    func deleteUser() {
        // TODO: db 에서 해당 유저 삭제
        // TODO: id token 애플 토큰 삭제
        self.isSignedIn = false
    }
}
