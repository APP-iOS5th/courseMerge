//
//  SettingView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    NavigationLink {
                        EditProfileView()
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 28)
                        Text("프로파일 수정")
                    }
                    NavigationLink {
//                        BlockedContactsView()
                    } label: {
                        Image(systemName: "person.slash")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 28)
                        Text("차단한 사용자 관리")
                    }
                } header: {
                    Text("일반")
                }
                Section {
                    NavigationLink {

                    } label: {
                        Image(systemName: "shield.lefthalf.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 28)
                        Text("개인정보 처리방침")
                    }
                    NavigationLink {

                    } label: {
                        Image(systemName: "doc.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 28)
                        Text("서비스 이용약관")
                    }
                   
                    NavigationLink {
                        
                    } label: {
                        Image(systemName: "hammer.fill")
                        Text("개발자 정보")
                    }
                    NavigationLink {

                    } label: {
                        Image(systemName: "exclamationmark.bubble.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 28)
                        Text("신고하기")
                    }
                    
                } header: {
                    Text("앱 정보")
                }
                Section {
                    NavigationLink {

                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 28)
                        Text("로그아웃")
                    }
                    NavigationLink {

                    } label: {
                        Image(systemName: "person.crop.circle.fill.badge.xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 28)
                        Text("회원탈퇴")
                    }
                    
                } header: {
                    Text("계정")
                }
            }
        }
    }
}

#Preview {
    SettingView()
}
