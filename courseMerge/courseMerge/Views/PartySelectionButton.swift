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

    var body: some View {
        Button {
            self.showingActionSheet = true
        } label: {
            HStack {
                Image(systemName: "line.3.horizontal")
                    .foregroundColor(.white)
                Text(partiesViewModel.currentParty.title)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(width: 130, height: 34)
            .font(.system(size: 15))
            .background(Color.blue)
            .cornerRadius(20)
            .confirmationDialog(
                "파티를 선택해주세요",
                isPresented: $showingActionSheet
            ) {
                ForEach(partiesViewModel.parties) { party in
                    Button {
                        partiesViewModel.currentParty = party
                    } label: {
                        Text(party.title)
                            .fontWeight(partiesViewModel.currentParty.title == party.title ? .bold : .regular)
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}

#Preview {
    PartySelectionButton()
}
