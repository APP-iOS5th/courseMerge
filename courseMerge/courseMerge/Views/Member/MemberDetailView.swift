//
//  MemberView_withMembers.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/10/24.
//

import SwiftUI

// MARK: - MemberDetailView - PartyInfo, Member Grid

struct MemberDetailView: View {
    @State private var isSharingSheetPresented = false
    @StateObject private var userViewModel = UserViewModel()
    //구성원 수정 시트 뷰모델
    @State private var isModifySheetPresented = false

    var body: some View {
        
        VStack{
            PartyInfoView(isModifySheetPresented: $isModifySheetPresented)
            
            MemberGridView(isSharingSheetPresented: $isSharingSheetPresented)
        }
        .environmentObject(userViewModel)
        .padding(10)
        .sheet(isPresented: $isModifySheetPresented) {
            MemberModifySheet()
        }
        .background(
            AppSharingSheet(
                isPresented: $isSharingSheetPresented,
                //아래는 테스트 주소, 앱 정보를 담은 링크를 보내야 함
                activityItems: [URL(string: "https://www.google.com")!]
            )
        )
    }
}


// MARK: - PartyInfoView

struct PartyInfoView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Binding var isModifySheetPresented: Bool

    @State private var partyDescr: String = "내용을 입력하세요."
    @State private var activatedPartyTitle: String = "제주도 파티"
    //설명 열고 닫기
    @State private var isDescrExpanded: Bool = false
    //호스트 표시
    var hasCrown: Bool = true
    
    var body: some View{
        HStack {
            //샘플
//            VStack {
//                ZStack {
//                    Circle().fill(.pastelRed)
//                        .frame(width: 100, height: 100)
//                    Image("ProfileMark")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 40, height: 40)
//                    if hasCrown {
//                        Image(systemName: "crown.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 30, height: 30)
//                            .foregroundColor(.white)
//                            .background(Color.yellow)
//                            .clipShape(Circle())
//                            .offset(x: 30, y: 35)
//                    }
//            
//                }
//                //2024.6.11 호스트 이름이 들어가야 함. (미작업)
//                Text("별빛여우")
//                    .foregroundStyle(.labelsPrimary)
//            }
            
            ProfileView(user: userViewModel.users.first!, width: 100, height: 100, overlayWidth: 30, overlayHeight: 50)
            
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        // 2024.6.11 작성한 파티 타이틀이 들어가야 함. (미작업)
                        Text("ex 제주도 파티")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.labelsPrimary)
                        //2024.6.11 선택한 날짜가 들어가야 함. (미작업)
                        Text("ex 2024.06.30")
                            .font(.callout)
                            .fontWeight(.regular)
                            .foregroundStyle(Color.labelsSecondary)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        isModifySheetPresented = true
                    }, label: {
                        Text("Edit")
                    })
                }
                Divider()
                //2024.6.11 파티 설명에서 입력한 내용이 들어가야 함. (미작업)
                DisclosureGroup("파티 설명", isExpanded: $isDescrExpanded) {
                    TextEditor(text: $partyDescr )
                        .frame(height: 10)
                        .foregroundColor(Color.labelsSecondary)
                        .padding()
                }
                .frame(maxHeight: isDescrExpanded ? 100 : 0)
                Divider()
            }
        }
    }
}


// MARK: - MemberGridView

struct MemberGridView: View {
    @EnvironmentObject var userViewModel: UserViewModel

    @Environment(\.colorScheme) var colorScheme
    
    @Binding var isSharingSheetPresented: Bool
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)

    var body: some View{
        ScrollView{
            LazyVGrid(columns: columns, spacing: 10) {
                
                Button {
                    isSharingSheetPresented = true
                } label: {
                    VStack {
                        ZStack {
                            Circle().fill(.bgSecondary)
                                .frame(width: 80, height: 80)
                            Image(systemName: "plus")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 30, height: 30)
                        }
                        Text("구성원 추가")
                            .foregroundStyle(.labelsPrimary)
                    }
                }
                
                ForEach(userViewModel.users) { user in
                    Button {
                        
                    } label: {
                        ProfileView(user: user, width: 75, height: 75, overlayWidth: 30, overlayHeight: 40)
                            .environmentObject(userViewModel)
                    }
                    .contextMenu {
                        Button {
                            
                        } label: {
                            NavigationLink(destination: EmptyView()) {
                                Label("대화하기", systemImage: "message")
                                    .foregroundColor(.labelsPrimary)
                            }
                        }
                        
                        Button(role: .destructive) {
                            
                        } label: {
                            Label("삭제하기", systemImage: "trash")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MemberDetailView()
}
