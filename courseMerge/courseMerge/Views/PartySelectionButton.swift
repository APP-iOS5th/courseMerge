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
    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel

    @State private var showingAddPartySheetView = false
    
    var body: some View {
        Button {
            self.showingActionSheet = true
        } label: {
            Label(partiesViewModel.currentParty.title, systemImage: "line.3.horizontal")
                .font(.subheadline)
                .foregroundStyle(.white)
                .padding(10)
                .frame(width: 130, height: 34)
                .background(Color.blue)
                .cornerRadius(20)
        }
        .confirmationDialog("파티를 선택해주세요.", isPresented: $showingActionSheet) {
            Button("새 파티 추가") { self.showingAddPartySheetView = true }
            
            ForEach(partiesViewModel.parties) { party in
                Button {
                    partiesViewModel.currentParty = party
                } label: {
                    Text(party.title)
                }
            }
        }
        .sheet(isPresented: $showingAddPartySheetView, content: {
            AddPartySheetView()
                .environmentObject(partiesViewModel)
        })
    }
}

#Preview {
    PartySelectionButton()
        .environmentObject(PartyDetailsViewModel())
}
