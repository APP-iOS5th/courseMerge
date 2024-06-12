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
        NavigationView {
            VStack {
                if partiesViewModel.parties.isEmpty {
                    MemberEmptyView()
                } else {
                    MemberDetailView()
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
