//
//  ChatView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/10/24.
//

import SwiftUI

struct ChatView: View {
    let item: GroupPartyInfo
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ChatView(item: GroupPartyInfo.exampleParties.first!)
    }
}
