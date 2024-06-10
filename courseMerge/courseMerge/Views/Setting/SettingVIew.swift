//
//  SettingView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        Form {
            Section {
                Text("프로파일 수정")
                Text("차단한 사용자 관리")
            } header: {
                Text("일반")
            }
            Section {
                Text("개인정보 처리방침")
                Text("서비스 이용약관")
                Text("개발자 정보")
                Text("신고하기")
            } header: {
                Text("앱 정보")
            }
            Section {
                Text("로그아웃")
                Text("회원탈퇴")
            } header: {
                Text("계정")
            }
        }
    }
}

#Preview {
    SettingView()
}
