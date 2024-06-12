//
//  AuthViewModel.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/11/24.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

// 사용자 인증 관련 ViewModel (자동 로그인, 로그아웃, 회원탈퇴)

class AuthViewModel: ObservableObject {
    @Published var isSignedIn: Bool = false
    @Published var currentUser: User? = nil
    
    init() {
        checkSignInStatus()
        
        // Listen for authentication state changes
        Auth.auth().addStateDidChangeListener { _, user in
            self.isSignedIn = (user != nil)
            if let user = user {
                self.loadCurrentUser(uid: user.uid)
            } else {
                self.currentUser = nil
            }
        }
    }
    
    func checkSignInStatus() {
        if let user = Auth.auth().currentUser {
            self.isSignedIn = true
            loadCurrentUser(uid: user.uid)
        } else {
            self.isSignedIn = false
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isSignedIn = false
            self.currentUser = nil
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    func loadCurrentUser(uid: String) {
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                self.currentUser = User(
                    uid: uid,
                    username: data?["username"] as? String ?? "",
                    usercolor: data?["usercolor"] as? String ?? "",
                    isHost: data?["isHost"] as? Bool ?? false
                )
                print("load CurrentUser: \(self.currentUser)")

            } else {
                print("Document does not exist")
            }
        }
    }
    
    func deleteUser(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "No user signed in", code: 401, userInfo: nil)))
            return
        }
        
        let uid = user.uid
        
        // Delete from Firestore
        let db = Firestore.firestore()
        db.collection("users").document(uid).delete { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Revoke ID token and delete user from Firebase Authentication
            user.getIDTokenResult(forcingRefresh: true) { _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                user.delete { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        print("before delete currentUser: \(self.currentUser)")
                        self.isSignedIn = false
                        self.currentUser = nil
                        print("after delete currentUser: \(self.currentUser)")
                        completion(.success(()))
                    }
                }
            }
        }
    }
}
