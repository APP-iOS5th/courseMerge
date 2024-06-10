//
//  LoginView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        Image("Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300, height: 300)
            .padding()
        
        Text("코스 머지")
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.labelsPrimary)
        
        Text("친구들의 코스를 하나로 합쳐보세요")
            .font(.callout)
            .fontWeight(.regular)
            .foregroundStyle(.labelsPrimary)
            .padding(.top, 20)
            .padding(.bottom, 70)

        
        Text("소셜 로그인으로 바로 시작하기")
            .font(.footnote)
            .fontWeight(.regular)
            .foregroundStyle(.labelsSecondary)
            .padding(.top,20)
        
        //애플 로그인
        SignInWithAppleButton(
            onRequest: { request in
            },
            onCompletion: { result in
                switch result {
                case .success(let authResults):
                    print("Authorization successful: \(authResults)")
                case .failure(let error):
                    print("Authorization failed: \(error.localizedDescription)")
                }
            }
        )
        .frame(width: 240, height: 53)
        
        //signInWithGoogle 사용 예정
        Button("Google 로그인") {
            
        }
        .padding()
        .foregroundColor(.black)
        .frame(width: 240, height: 53)
        .background(.fillTertiary)
        .padding(.top,20)
    }
}

#Preview {
    LoginView()
}
