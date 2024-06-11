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

class AuthViewModel: ObservableObject {
    @Published var isSignedIn: Bool = false
    
    init() {
        checkSignInStatus()
        
        // Listen for authentication state changes
        Auth.auth().addStateDidChangeListener { _, user in
            self.isSignedIn = (user != nil)
        }
    }
    
    func checkSignInStatus() {
        self.isSignedIn = Auth.auth().currentUser != nil
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isSignedIn = false
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
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
                        completion(.success(()))
                    }
                }
            }
        }
    }
}
