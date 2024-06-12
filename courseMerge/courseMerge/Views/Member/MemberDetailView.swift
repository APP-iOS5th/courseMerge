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
    @StateObject public var memberDetailViewModel: MemberDetailViewModel
    //구성원 수정 시트 뷰모델
    @State private var isModifySheetPresented = false

    var body: some View {
        
        VStack{
            PartyInfoView(memberDetailViewModel: memberDetailViewModel, isModifySheetPresented: $isModifySheetPresented)
            
            MemberGridView(memberDetailViewModel: memberDetailViewModel,isSharingSheetPresented: $isSharingSheetPresented)
        }
        .environmentObject(userViewModel)
        .environmentObject(memberDetailViewModel)
        .padding(10)
        .sheet(isPresented: $isModifySheetPresented) {
            MemberModifySheet().environmentObject(memberDetailViewModel)
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
    @ObservedObject var memberDetailViewModel: MemberDetailViewModel
    @Binding var isModifySheetPresented: Bool

    @State private var partyDescr: String = "내용을 입력하세요."
    @State private var activatedPartyTitle: String = "제주도 파티"
    //설명 열고 닫기
    @State private var isDescrExpanded: Bool = false
    //호스트 표시
    var hasCrown: Bool = true
    
    // 날짜를 원하는 형식으로 포맷하는 프로퍼티
    var formattedStartDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: memberDetailViewModel.startDate)
    }

    var formattedEndDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: memberDetailViewModel.endDate)
    }
    
    var body: some View{
        HStack {
            
            ProfileView(user: userViewModel.users.first!, width: 100, height: 100, overlayWidth: 30, overlayHeight: 50,isUsername: true)
            
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        // 2024.6.11 작성한 파티 타이틀이 들어가야 함. (미작업)
                        Text(memberDetailViewModel.partytitle)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.labelsPrimary)
                        //2024.6.11 선택한 날짜가 들어가야 함./ 년월일만 출력 (미작업)
                        Text("\(formattedStartDate) ~ \(formattedEndDate)")
                            .font(.footnote)
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
                DisclosureGroup(memberDetailViewModel.partyDescr, isExpanded: $isDescrExpanded) {
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
    @ObservedObject var memberDetailViewModel: MemberDetailViewModel

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
                //ForEach(userViewModel.users) { user in
                ForEach(memberDetailViewModel.createdPartInfo) { partys in
                    ForEach(partys.members){ user in
                        Button {
                            
                        } label: {
                            ProfileView(user: user, width: 75, height: 75, overlayWidth: 30, overlayHeight: 40,isUsername: true)
                                //.environmentObject(userViewModel)
                                .environmentObject(memberDetailViewModel)
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
                                userViewModel.deleteUser(withUID: user.uid)
                            } label: {
                                Label("삭제하기", systemImage: "trash")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MemberDetailView(memberDetailViewModel: MemberDetailViewModel())
}
