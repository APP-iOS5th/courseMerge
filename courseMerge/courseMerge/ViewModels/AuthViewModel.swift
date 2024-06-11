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
        if Auth.auth().currentUser != nil {
            self.isSignedIn = true
        } else {
            self.isSignedIn = false
        }
    }
}
