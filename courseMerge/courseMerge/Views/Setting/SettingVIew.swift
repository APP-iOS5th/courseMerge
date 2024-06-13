//
//  SettingView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var showAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    NavigationLink {
                        UpdateProfileView()
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 28)
                            .foregroundStyle(colorScheme == .dark ? Color("BGSecondary") : Color("BGTertiaryDarkElevated"))
                        Text("프로필 수정")
                    }
                    
                    NavigationLink {
                        BlockedContactsView()
                    } label: {
                        Image(systemName: "person.slash")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 28)
                            .foregroundStyle(colorScheme == .dark ? Color("BGSecondary") : Color("BGTertiaryDarkElevated"))
                        Text("차단한 사용자 관리")
                    }
                } header: {
                    Text("일반")
                }
                Section {
                    NavigationLink {
                        PrivacyPolicyView()
                    } label: {
                        Image(systemName: "shield.lefthalf.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 28)
                            .foregroundStyle(colorScheme == .dark ? Color("BGSecondary") : Color("BGTertiaryDarkElevated"))
                        Text("개인정보 처리방침")
                            .padding(.leading, 5)
                    }
                    NavigationLink {
                        TermsOfServiceView()
                    } label: {
                        Image(systemName: "doc.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 28)
                            .padding(.leading, 2)
                            .foregroundStyle(colorScheme == .dark ? Color("BGSecondary") : Color("BGTertiaryDarkElevated"))
                        Text("서비스 이용약관")
                            .padding(.leading, 3)
                    }
                    
                    NavigationLink {
                        DevelopersDetailsView()
                    } label: {
                        Image(systemName: "hammer.fill")
                            .foregroundStyle(colorScheme == .dark ? Color("BGSecondary") : Color("BGTertiaryDarkElevated"))
                        Text("개발자 정보")
                            .padding(.leading, 3)
                    }
                    NavigationLink {
                        ReportView()
                    } label: {
                        Image(systemName: "exclamationmark.bubble.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 28)
                            .padding(.leading, -3)
                            .foregroundStyle(colorScheme == .dark ? Color("BGSecondary") : Color("BGTertiaryDarkElevated"))
                        Text("신고하기")
                            .padding(.leading, 1)
                    }
                    
                } header: {
                    Text("앱 정보")
                }
                
                Section {
                    Button(action: {
                        print(authViewModel.isSignedIn)
                        showAlert = true
                    }) {
                        HStack{
                            Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 23)
                                .foregroundStyle(colorScheme == .dark ? Color("BGSecondary") : Color("BGTertiaryDarkElevated"))
                            Text("로그아웃")
                                .padding(.leading,2)
                                .foregroundColor(.labelsPrimary)
                        }
                    }
                    .padding(.leading, 2)
                    
                    .alert("알림", isPresented: $showAlert) {
                        Button("취소", role: .cancel) {
                            showAlert = false
                        }
                        Button {
                            authViewModel.signOut()
                            print(authViewModel.isSignedIn)

                        } label: {
                            Text("확인")
                        }
                    } message: {
                        Text("로그아웃 하시겠습니까?")
                    }
                
                    
                    NavigationLink {
                        AccountDeletionView()
                            .environmentObject(authViewModel)
                    } label: {
                        Image(systemName: "person.crop.circle.fill.badge.xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 28)
                            .padding(.leading, -4)
                            .foregroundStyle(colorScheme == .dark ? Color("BGSecondary") : Color("BGTertiaryDarkElevated"))
                        Text("회원탈퇴")
                            .padding(.leading, 1)
                    }
                    
                } header: {
                    Text("계정")
                }
                
            }//폼
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
        }//네비게이션스택
    }
}

#Preview {
    SettingView()
        .environmentObject(AuthViewModel())
    
}
