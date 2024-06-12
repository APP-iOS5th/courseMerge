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
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel

    //구성원 수정 시트
    @State private var isModifySheetPresented = false

    var body: some View {
        VStack {
            PartyInfoView(party: partiesViewModel.currentParty, isModifySheetPresented: $isModifySheetPresented)
            
            MemberGridView(party: partiesViewModel.currentParty, isSharingSheetPresented: $isSharingSheetPresented)
        }
        .environmentObject(userViewModel)
        .environmentObject(partiesViewModel)
        .padding(10)
        .sheet(isPresented: $isModifySheetPresented) {
//            UpdatePartySheetView()
//                .environmentObject(partiesViewModel)

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
    let party: PartyDetail

    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel
    
    @Binding var isModifySheetPresented: Bool
    
    //설명 열고 닫기
    @State private var isDescrExpanded: Bool = false
    

    
    var body: some View {
        HStack {
//            let hosts = party.members.filter { $0.isHost }
//            if let host = hosts.first {
//                ProfileView(user: host, width: 100, height: 100, overlayWidth: 30, overlayHeight: 50, isUsername: true)
//                    .environmentObject(userViewModel)
//            }
            
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(party.title)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.labelsPrimary)
                        
                        //2024.6.11 선택한 날짜가 들어가야 함./ 년월일만 출력 (미작업)
                        Text("\(party.formattedStartDate) ~ \(party.formattedEndDate)")
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
                
                DisclosureGroup(party.description, isExpanded: $isDescrExpanded) {}
                    .frame(maxHeight: isDescrExpanded ? 100 : 0)
                
                Divider()
            }
        }
        .padding(.horizontal, 10)
    }
}


// MARK: - MemberGridView

struct MemberGridView: View {
    let party: PartyDetail

    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var isSharingSheetPresented: Bool
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)

    var body: some View {
        ScrollView {
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
                ForEach(party.members) { user in
                    Button {
                        
                    } label: {
                        ProfileView(user: user, width: 75, height: 75, overlayWidth: 30, overlayHeight: 40, isUsername: true)
                            .environmentObject(userViewModel)
                    }
                    // TODO: design
                    .contextMenu {
                        Button {
                            
                        } label: {
                            NavigationLink(destination: EmptyView()) {
                                Label("대화하기", systemImage: "message")
                                    .foregroundColor(.labelsPrimary)
                            }
                        }
                        
                        Button(role: .destructive) {
                            // 파티원삭제는 -> 파티 뷰 모델에서 관리
                        } label: {
                            Label("삭제하기", systemImage: "trash")
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    MemberDetailView()
//}
