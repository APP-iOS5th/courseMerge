//
//  MemberView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI

struct MemberView: View {
    
    @State private var createdParties: [GroupPartyInfo] = GroupPartyInfo.exampleParties
    
    var body: some View {
        NavigationView {
            VStack {
                if createdParties.isEmpty
                {
                    MemberEmptyView()
                } else {
                    MemberDetailView()
                }
            }
            .navigationTitle("구성원")
        }
    }
}

#Preview {
    MemberView()
}
