//
//  MemberView_withMembers.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/10/24.
//

import SwiftUI

struct MemberDetailView: View {
    @State private var isSharingSheetPresented = false
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel

    //구성원 수정 시트
    @State private var isModifySheetPresented = false

    var body: some View {
        VStack(spacing: 20) {
            if let currentParty = partiesViewModel.currentParty {
                PartyInfoView(party: currentParty, isModifySheetPresented: $isModifySheetPresented)
                
                Divider()
                
                MemberGridView(party: currentParty, isSharingSheetPresented: $isSharingSheetPresented)
            }
            
        }
        .environmentObject(authViewModel)
        .environmentObject(partiesViewModel)
        .padding(10)
        .fullScreenCover(isPresented: $isModifySheetPresented) {
            UpdatePartySheetView(party: partiesViewModel.currentParty!)
                .environmentObject(partiesViewModel)
        }
        .background(
            AppSharingSheet(
                isPresented: $isSharingSheetPresented,
                activityItems: [URL(string: "https://vlw1p.app.link/courseMerge")!]
            )
            .onAppear {
                //partiesViewModel.checkLoginFromTestLink()
            }
        )
    }
}


// MARK: - PartyInfoView

struct PartyInfoView: View {
    let party: PartyDetail
    
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel
    
    @Binding var isModifySheetPresented: Bool
    @State private var isExpanded = false
    let maxDescriptionLength = 100
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                let hosts = party.members.filter { $0.isHost }
                if let host = hosts.first {
                    ProfileView(user: host, width: 90, height: 90, overlayWidth: 30, overlayHeight: 50, isUsername: true)
//                        .environmentObject(authViewModel)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(party.title)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.labelsPrimary)
                        
                        Spacer()
                        
                        Button(action: {
                            isModifySheetPresented = true
                        }) {
                            Text("Edit")
                                .foregroundColor(.blue)
                        }
                    }
                    
                    Text("\(party.formattedStartDate) ~ \(party.formattedEndDate)")
                        .font(.footnote)
                        .fontWeight(.regular)
                        .foregroundStyle(.labelsSecondary)
                }
                .padding(.leading)
            }
            HStack {
                if party.description.count > maxDescriptionLength {
                    DisclosureGroup(isExpanded: $isExpanded) {
                        Text(party.description)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                    } label: {
                        Text(isExpanded ? "접기" : "더보기")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                    .animation(.default)
                } else {
                    Text(party.description)
                        .font(.footnote)    // 수정
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 10)
    }
}



// MARK: - MemberGridView

struct MemberGridView: View {
    let party: PartyDetail

    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var isSharingSheetPresented: Bool
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                Button {
                    isSharingSheetPresented = true
                    //에러로 인한 주석처리
                    //partiesViewModel.checkLoginFromTestLink()
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
                ForEach(partiesViewModel.parties) { party in
                    ForEach(party.members) {user in
                        Button {
                            
                        } label: {
                            ProfileView(user: user, width: 75, height: 75, overlayWidth: 30, overlayHeight: 40, isUsername: true)
                                .environmentObject(authViewModel)
                                .environmentObject(partiesViewModel)
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
                //}
                /*ForEach(party.members.filter { !$0.isHost }) { user in
                    Button {
                        
                    } label: {
                        ProfileView(user: user, width: 75, height: 75, overlayWidth: 30, overlayHeight: 40, isUsername: true)
                            .environmentObject(authViewModel)
                            .environmentObject(partiesViewModel)
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
                }*/
            }
        }
    }
}

struct MemberDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack {
                MemberDetailView()
                    .environmentObject(AuthViewModel())
                    .environmentObject(PartyDetailsViewModel())
            }
            .navigationTitle("구성원")
            .toolbar {
                PartySelectionButton()
                    .environmentObject(AuthViewModel())
                    .environmentObject(PartyDetailsViewModel())
            }
        }
    }
}
