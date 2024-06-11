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
import FirebaseFirestore

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
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
            Group {
                if colorScheme == .light {
                    SignInWithAppleButtonView()
                        .signInWithAppleButtonStyle(.black)
                } else {
                    SignInWithAppleButtonView()
                        .signInWithAppleButtonStyle(.white)
                }
            }
            .environmentObject(authViewModel)
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
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        SignInWithAppleButton(
            .signUp,
            onRequest: { request in // ASAuthorizationAppleIDProvider ??
                let nonce = randomNonceString()
                currentNonce = nonce
                request.requestedScopes = []    // email, name 모두 필요x
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
                self.authViewModel.isSignedIn = true    // ContentView 로 이동!!!
                // 현재 사용자 UID 확인
                if let user = Auth.auth().currentUser {
                    let uid = user.uid

                    // Firestore에서 사용자 문서 가져오기
                    let db = Firestore.firestore()
                    let userRef = db.collection("users").document(uid)
                    userRef.getDocument { (document, error) in
                        // 기존 사용자일 경우
                        if let document = document, document.exists {
                            print("User already exists")
                        } else {
                            // 새로운 사용자 생성
                            let randomUsername = generateRandomUsername()
                            let newUser = User(uid: uid, username: randomUsername, usercolor: "pastelBlue", isHost: false)
                            userRef.setData([
                                "uid": newUser.uid,
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

// 한글 닉네임 생성기
private func generateRandomUsername() -> String {
    let determiners = [
        "예쁜", "화난", "귀여운", "배고픈", "철학적인",
        "현학적인", "슬픈", "푸른", "비싼", "밝은"
    ]
    
    let animals = [
        "호랑이", "비버", "강아지", "부엉이", "여우",
        "치타", "문어", "고양이", "미어캣", "다람쥐"
    ]
    
    let randomDeterminer = determiners.randomElement() ?? "사용자"
    let randomAnimal = animals.randomElement() ?? "사용자"
    
    return "\(randomDeterminer)\(randomAnimal)\(Int.random(in: 1000...9999))"
}
