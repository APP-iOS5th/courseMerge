//
//  MemberView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI

struct MemberView: View {
    
    @State private var createdParties: [GroupPartyInfo] = []
    
    var body: some View {
        NavigationView {
            VStack {
                if createdParties.isEmpty {
                    MemberView_empty()
                } else {
                    Text("생성한 파티 목록이 있습니다.")
                }
            }
            .navigationTitle("구성원")
        }
    }
}

#Preview {
    MemberView()
}
