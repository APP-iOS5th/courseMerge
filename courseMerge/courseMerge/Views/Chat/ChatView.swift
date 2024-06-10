//
//  ChatView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/10/24.
//

import SwiftUI

struct ChatView: View {
    let item: ChatList
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ChatView(item: ChatList.example.first!)
    }
}
