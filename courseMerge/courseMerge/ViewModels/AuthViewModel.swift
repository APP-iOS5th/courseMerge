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
import AuthenticationServices
import SwiftUI

// 사용자 인증 관련 ViewModel (자동 로그인, 로그아웃, 회원탈퇴)

class AuthViewModel: ObservableObject {
    @Published var isSignedIn: Bool = false
    @Published var currentUser: User? = nil
    @Published var currentUserUID: String?
    @Published var goToLoginView: Bool = false
    
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
        
        fetchCurrentUserUID()
    }
    
    func fetchCurrentUserUID() {
        if let uid = Auth.auth().currentUser?.uid {
            currentUserUID = uid
        } else {
            print("No current user logged in.")
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
                print("load CurrentUser: \(String(describing: self.currentUser))")

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
                        self.isSignedIn = false
                        self.currentUser = nil
                        completion(.success(()))
                    }
                }
            }
        }
    }
    
    func updateUser(uid: String, userName: String, userColor: String, isHost: Bool, completion: @escaping (Result<User, Error>) -> Void) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)
        
        userRef.updateData([
            "username": userName,
            "usercolor": userColor,
            "isHost": isHost
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.loadCurrentUser(uid: uid)
                if let updatedUser = self.currentUser {
                    completion(.success(updatedUser))
                } else {
                    completion(.failure(NSError(domain: "Update Failed", code: 500, userInfo: nil)))
                }
            }
        }
    }
    
//    
//    func checkLoginFromTestLink() {
//        guard let url = URL(string: "testflight_link") else { return }
//        
//        session = ASWebAuthenticationSession(url: url, callbackURLScheme: "courseMerge") { [weak self] callbackURL, error in
//            guard let self = self else { return }
//            
//            guard error == nil, let callbackURL = callbackURL else {
//                // Error 처리
//                print("Error: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            if callbackURL.absoluteString.contains("apple_login=true") {
//                print("Apple login successful")
//                partyDetailsViewModel.addParty()
//            } else {
//                print("Apple login failed or not verified")
//                // 실패했을 때의 처리를 알림 추가
//            }
//        }
//        
//        session?.presentationContextProvider = self
//        session?.start()
//    }
}
