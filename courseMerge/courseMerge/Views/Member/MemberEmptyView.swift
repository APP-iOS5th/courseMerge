//
//  MemberView_empty.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/10/24.
//

import SwiftUI

struct MemberEmptyView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject public var memberDetailViewModel: MemberDetailViewModel
    //구성원 추가 시트 뷰모델
    @State private var isAddSheetPresented = false
    // 파티 가입 여부 확인
    @State private var isPartyJoined = false
    
    var body: some View {
        NavigationView{
            VStack{
                if !isPartyJoined {
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
                        isAddSheetPresented = true
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
                    
                    Button(action: {
                        // 여기에 기존 파티에 가입하기 버튼의 액션 추가
                    }) {
                        Text("기존 파티에 가입하기")
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                            .frame(width: 170, height: 53)
                            .background(Color.bgSecondary)
                            .cornerRadius(10)
                    }
                    .padding()
                } else {
                    NavigationLink(destination: MemberDetailView(memberDetailViewModel: memberDetailViewModel)) {
                        MemberDetailView(memberDetailViewModel: memberDetailViewModel)
                    }
                    .environmentObject(MemberDetailViewModel())
                }
            }
            .sheet(isPresented: $isAddSheetPresented, onDismiss: {
                if !memberDetailViewModel.partyTitle.isEmpty {
                    isPartyJoined = true
                }
                else {
                    print("no move")
                }
            }) {
                MemberAddSheet().environmentObject(memberDetailViewModel)
            }
        }
    }
}

#Preview {
    MemberEmptyView(memberDetailViewModel: MemberDetailViewModel())
}
