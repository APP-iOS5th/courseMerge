//
//  MemberView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI

struct MemberView: View {

    @State private var createdParties: [GroupPartyInfo] = GroupPartyInfo.exampleParties
    
    @Environment(\.colorScheme) var colorScheme
        
    var body: some View {
        NavigationView {
            VStack {
                
                if createdParties.isEmpty
                {
                    MemberEmptyView()
                } else {
                    MemberHeaderView()
                    MemberDetailView()
                }
            }
        }
    }
}


struct MemberHeaderView: View {
    @State private var isShowSearchViewModal: Bool = false
    
    var body: some View {
        VStack {
            HStack{
                Text("구성원")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 52)
                
                PartySelectionButton()
            }
            Divider()
        }
        .sheet(isPresented: $isShowSearchViewModal) {
            SearchView()
        }
        .padding(.horizontal)
        .background(Color.white)
        
    }
}


#Preview {
    MemberView()
}
