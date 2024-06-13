//
//  PartySelectionButton.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/12/24.
//

import SwiftUI

// MARK: - 파티를 선택할 수 있는 버튼(actionSheet)

struct PartySelectionButton: View {
    @State private var showingActionSheet = false

    @State private var showingAddPartySheetView = false
    @State private var showLoginAlert = false

    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel
    @EnvironmentObject var authViewModel: AuthViewModel

    
    var body: some View {
        if let currentParty = partiesViewModel.currentParty {
            Button {
                self.showingActionSheet = true
            } label: {
                Label(currentParty.title, systemImage: "line.3.horizontal")
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .padding(10)
                    .frame(width: 130, height: 34)
                    .background(Color.blue)
                    .cornerRadius(20)
            }
            .confirmationDialog("파티를 선택해주세요.", isPresented: $showingActionSheet) {
                Button("새 파티 추가") {
                    self.showingAddPartySheetView = true
                }
                
                ForEach(partiesViewModel.parties) { party in
                    Button {
                        self.partiesViewModel.currentParty = party
                    } label: {
                        Text(party.title)
                    }
                }
            }

            .sheet(isPresented: $showingAddPartySheetView, content: {
                AddPartySheetView()
                    .environmentObject(partiesViewModel)
                    .environmentObject(authViewModel)
            })
            .task {
                partiesViewModel.fetchParties()
            }
        } else {    // 파티가 없는 경우
            Button {
                if authViewModel.isSignedIn {   // 파티가 없고, 로그인된 경우
                    self.showingAddPartySheetView = true    // 새 파티 만들기
                } else {
                    showLoginAlert = true   // 파티가 없고, 로그인 x 는 로그인뷰 알람
                }
            } label: {
                Label("새 파티 추가", systemImage: "line.3.horizontal")
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .padding(10)
                    .frame(width: 130, height: 34)
                    .background(Color.blue)
                    .cornerRadius(20)
            }
            // for guest login
            .alert("로그인이 필요합니다.", isPresented: $showLoginAlert) {
                Button("취소", role: .cancel) {
                    showLoginAlert = false
                }
                Button("확인") {
                    authViewModel.isSignedIn = false
                    authViewModel.goToLoginView = true
                }
            } message: {
                Text("파티를 만들기 위해서는 로그인이 필요합니다. 로그인을 해주세요.")
            }
        }
    }
}

#Preview {
    PartySelectionButton()
        .environmentObject(PartyDetailsViewModel(authViewModel: AuthViewModel()))
        .environmentObject(AuthViewModel())
}
