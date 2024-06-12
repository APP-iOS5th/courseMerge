//
//  MemberView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI

struct MemberView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel
    @EnvironmentObject var authViewModel: AuthViewModel

    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack {
                if partiesViewModel.parties.isEmpty {
                    
                    MemberEmptyView()
                    
                } else {
                    
                    MemberDetailView()
                }
            }
            .task {
                if let currentParty = partiesViewModel.currentParty {
                    print("current Party :: \(currentParty)")
                }
                partiesViewModel.fetchParties()
            }
            .onReceive(partiesViewModel.$currentParty) { newParty in
                if let newParty = newParty {
                    print("Updated current party: \(newParty)")
                } else {
                    print("No current party selected")
                }
            }
            .environmentObject(partiesViewModel)
            .environmentObject(userViewModel)
            
            .navigationTitle("구성원")
            .toolbar {
                PartySelectionButton()
                    .environmentObject(partiesViewModel)
            }
        }
    }
}

#Preview {
    MemberView()
}
