//
//  LoginView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI
import AuthenticationServices

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

