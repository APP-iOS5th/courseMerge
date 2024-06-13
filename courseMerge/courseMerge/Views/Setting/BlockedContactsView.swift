//
//  BlockedContactsView.swift
//  CourseMerge
//
//  Created by mini on 6/10/24.
//

import SwiftUI

struct BlockedContactsView: View {
    @State private var blockedList = BlockedData.exampleBlocked

    var body: some View {
        NavigationView {
            List {
                ForEach($blockedList) { $item in
                    ForEach($item.users) { $blocked in
                        NavigationLink(destination: Text(blocked.username)) {
                            HStack {
                                ProfileView(user: blocked, width: 40, height: 40, overlayWidth: 15, overlayHeight: 15, isUsername: false)
                                Text(blocked.username)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        deleteUser(at: indexSet, from: item)
                    }
                    .onMove { indices, newOffset in
                        moveUser(from: indices, to: newOffset, in: item)
                    }
                }
            }
            .navigationTitle("차단한 사용자 관리")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }

    private func deleteUser(at offsets: IndexSet, from blockedData: BlockedData) {
        for index in offsets {
            if let itemIndex = blockedList.firstIndex(where: { $0.id == blockedData.id }) {
                blockedList[itemIndex].users.remove(at: index)
            }
        }
    }

    private func moveUser(from source: IndexSet, to destination: Int, in blockedData: BlockedData) {
        if let itemIndex = blockedList.firstIndex(where: { $0.id == blockedData.id }) {
            blockedList[itemIndex].users.move(fromOffsets: source, toOffset: destination)
        }
    }
}



#Preview {
    BlockedContactsView()
        .environmentObject(AuthViewModel())
}
