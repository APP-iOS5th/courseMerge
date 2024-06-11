//
//  LoginView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import AuthenticationServices
import CryptoKit

struct LoginView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        VStack {
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .padding()
            
            Text("코스 머지")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("친구들의 코스를 하나로 합쳐보세요")
                .font(.callout)
                .fontWeight(.regular)
                .foregroundColor(.primary)
                .padding(.top, 20)
                .padding(.bottom, 70)

            
            Text("소셜 로그인으로 바로 시작하기")
                .font(.footnote)
                .fontWeight(.regular)
                .foregroundColor(.secondary)
                .padding(.top,20)
            
            // 애플 로그인 버튼
            if colorScheme == .light {
                SignInWithAppleButtonView()
                    .signInWithAppleButtonStyle(.black)
            } else {
                SignInWithAppleButtonView()
                    .signInWithAppleButtonStyle(.white)
            }
        }
    }
}

#Preview {
    LoginView()
}

/*
 //signInWithGoogle 사용 예정
 Button("Google 로그인") {
     
 }
 .padding()
 .foregroundColor(.black)
 .frame(width: 240, height: 53)
 .background(.fillTertiary)
 .padding(.top,20)
 */



struct SignInWithAppleButtonView: View {
    @State private var currentNonce: String?
    
    var body: some View {
        SignInWithAppleButton(
            .signUp,
            onRequest: { request in // ASAuthorizationAppleIDProvider ??
                let nonce = randomNonceString()
                currentNonce = nonce
                request.requestedScopes = [.fullName, .email]
                request.nonce = sha256(nonce)
            },
            onCompletion: { result in
                switch result {
                case .success(let authorization):
                    handleAuthorization(authorization)
                case .failure(let error):
                    print("Sign in with Apple failed: \(error.localizedDescription)")
                }
            }
        )
        .frame(width: 240, height: 53)
    }

    private func handleAuthorization(_ authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
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
                // Handle successful sign in here
                if let fullName = appleIDCredential.fullName {
                    let displayName = "\(fullName.givenName ?? "") \(fullName.familyName ?? "")"
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = displayName
                    changeRequest?.commitChanges { error in
                        if let error = error {
                            print("Failed to update display name: \(error.localizedDescription)")
                        } else {
                            print("Display name updated to \(displayName)")
                        }
                    }
                }
                
                
            }
        }
    }
}

@available(iOS 13, *)
private func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    var randomBytes = [UInt8](repeating: 0, count: length)
    let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
    if errorCode != errSecSuccess {
        fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
    }

    let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    let nonce = randomBytes.map { byte in
        charset[Int(byte) % charset.count]
    }
    return String(nonce)
}

@available(iOS 13, *)
private func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap { String(format: "%02x", $0) }.joined()
    return hashString
}
