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
    @State private var showingContentView: Bool = false
    
    var body: some View {
        // 어차피 guest login 은 LoginView 에서 시작한 ContentView이기 때문에, viewModel 에서 관리하는 goToLoginView를 조건문에 추가하면 끝!
        ZStack {
            if showingContentView && authViewModel.goToLoginView == false {
                ContentView()
                    .environmentObject(authViewModel)
            } else {
                VStack(spacing: 10) {
                    Spacer()
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .padding()
                    
                    
                    
                    Text("코스 머지")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text("친구들의 코스를 하나로 합쳐보세요")
                        .font(.callout)
                        .fontWeight(.regular)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    
                    Text("소셜 로그인으로 바로 시작하기")
                        .font(.footnote)
                        .fontWeight(.regular)
                        .foregroundColor(.secondary)
                    
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
                    
                    
                    Button {
                        showingContentView = true
                        authViewModel.goToLoginView = false // 로그인 안하고 다시 둘러보기 올 수도 있어서
                    } label: {
                        Text("둘러보기")
                            .font(.headline)
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}

