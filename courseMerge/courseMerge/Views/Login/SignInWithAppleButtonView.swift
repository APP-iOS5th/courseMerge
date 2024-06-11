//
//  SignInWithAppleButtonView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/11/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import AuthenticationServices
import CryptoKit

struct SignInWithAppleButtonView: View {
    @State private var currentNonce: String?
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        SignInWithAppleButton(
            .signUp,
            onRequest: { request in
                configureRequest(request)
            },
            onCompletion: { result in
                handleCompletion(result)
            }
        )
        .frame(width: 240, height: 53)
    }
    
    private func configureRequest(_ request: ASAuthorizationAppleIDRequest) {
        let nonce = randomNonceString()
        currentNonce = nonce
        request.requestedScopes = [] // email, name 모두 필요 없음
        request.nonce = sha256(nonce)
    }

    private func handleCompletion(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            handleAuthorization(authorization)
        case .failure(let error):
            print("Sign in with Apple failed: \(error.localizedDescription)")
        }
    }

    private func handleAuthorization(_ authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        guard let nonce = currentNonce else {
            fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }
        guard let appleIDToken = appleIDCredential.identityToken else {
            print("Unable to fetch identity token")
            return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            return
        }

        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("User is signed in to Firebase with Apple.")
            self.authViewModel.isSignedIn = true
            handleFirebaseUser()
        }
    }

    private func handleFirebaseUser() {
        guard let user = Auth.auth().currentUser else { return }
        let uid = user.uid
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                print("User already exists")
            } else {
                fetchExistingUsernames { excludeUsernames in
                    createNewUser(uid: uid, userRef: userRef, excludeUsernames: excludeUsernames)
                }
            }
        }
    }

    private func fetchExistingUsernames(completion: @escaping ([String]) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                completion([])
                return
            }
            let excludeUsernames = snapshot?.documents.compactMap { $0.data()["username"] as? String } ?? []
            completion(excludeUsernames)
        }
    }

    // MARK: - Create New User
    
    private func createNewUser(uid: String, userRef: DocumentReference, excludeUsernames: [String]) {
        
        let randomUsername = User.generateRandomUsername(excludeUsernames: excludeUsernames)
        let randomColor = User.randomColor()
        let newUser = User(uid: uid, username: randomUsername, usercolor: randomColor, isHost: false)
        
        userRef.setData([
            "uid": newUser.uid as Any,
            "username": newUser.username,
            "usercolor": newUser.usercolor,
            "isHost": newUser.isHost
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("User successfully created!")
            }
        }
    }
}



@available(iOS 13, *)
func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    var randomBytes = [UInt8](repeating: 0, count: length)
    let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
    if errorCode != errSecSuccess {
        fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
    }

    let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    let nonce = randomBytes.map { byte in charset[Int(byte) % charset.count] }
    return String(nonce)
}

@available(iOS 13, *)
func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap { String(format: "%02x", $0) }.joined()
    return hashString
}



