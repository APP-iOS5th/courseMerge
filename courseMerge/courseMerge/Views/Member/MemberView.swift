//
//  MemberView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI

struct MemberView: View {
    
    // 화면에 시트를 표시 여부 확인
    @State private var showJoinPartySheet = false
    
    // 파티 가입 여부 확인
    @State private var isPartyJoined = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isPartyJoined { // 파티에 가입되어 있는 경우
                    // 네비게이션 stack
                    Text("구성원뷰")
                } else {
                    // 파티에 가입되어 있지 않은 경우 (default)
                    Image(systemName: "person.2.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                    Text("현재 참여중인 파티가 없습니다.\n새로운 파티를 만들거나\n링크가 있다면 초대된 파티에 들어가보세요.")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding()
                    Button(action: {
                        // 새 파티 만들기 함수
                    }) {
                        Text("새 파티 만들기")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 120, height: 53)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                    Text("초대링크를 가지고 있나요?")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.top, 20)
                    // 기존 파티에 가입하기 버튼
                    Button(action: {
                        // 기존 파티에 가입하기 버튼을 눌렀을 때 시트를 표시하기 위해 showJoinPartySheet 상태 변수를 true로 설정
                        showJoinPartySheet = true
                    }) {
                        Text("기존 파티에 가입하기")
                            .fontWeight(.regular)
                            .foregroundColor(.primary)
                            .frame(width: 170, height: 53)
                            .background(Color.secondary)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .navigationTitle("구성원")
            // 시트를 표시하기 위해 sheet modifier 사용
            .sheet(isPresented: $showJoinPartySheet) {
                // 시트에 표시할 뷰를 지정
                MemberPartySettingSheet()
            }
        }
    }
}

#Preview {
    MemberView()
}
