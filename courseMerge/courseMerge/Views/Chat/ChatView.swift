//
//  ChatView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/10/24.
//

import SwiftUI

struct Message: Hashable {
    var id = UUID()
    var content: String
    var isCurrentUser: Bool
}

struct ChatView: View {
    let item: GroupPartyInfo
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            Text("This is a single message cell.")
                .padding(10)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .roundedCorner(10, corners: [.topLeft, .bottomLeft, .bottomRight])

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(colorScheme == .dark ? Color("BGSecondaryDarkElevated") : Color("BGSecondary"))
        .navigationTitle(item.title)
        .toolbarBackground(colorScheme == .dark ? Color("BGPrimaryDarkElevated") : Color("BGPrimary"), for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
    }
}



#Preview {
    NavigationStack {
        ChatView(item: GroupPartyInfo.exampleParties.first!)
    }
}
