//
//  MemberView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI

struct MemberView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var createdParties: [GroupPartyInfo] = []
    
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
