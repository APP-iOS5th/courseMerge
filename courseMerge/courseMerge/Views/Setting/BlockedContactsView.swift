//
//  BlockedContactsView.swift
//  CourseMerge
//
//  Created by mini on 6/10/24.
//

import SwiftUI
struct BlockedItem: Identifiable {
    var id = UUID()
    var text: String
}
struct BlockedContactsView: View {
    @State var blockedList: [BlockedItem] = [
        BlockedItem(text: "+82 1688-3131"),
        BlockedItem(text: "+82 1688-3132"),
    ]
    @State var flag = false
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(blockedList) { item in
                    NavigationLink(value: item.text) {
                        Text(item.text)
                    }
                }
                .onDelete { blockedList.remove(atOffsets: $0)}
                .onMove { blockedList.move(fromOffsets: $0, toOffset: $1)}
                
                Button("추가하기...") {
                   let newItem = BlockedItem(text: "1335")
                    blockedList.append(newItem)
                }
                .disabled(flag)
            }
            .navigationDestination(for: String.self) { text in
                Text("blocked item = \(text)")
            }
        }//NavigationStack
        .navigationTitle("차단한 사용자 관리")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
            
        }
    }//body
}



#Preview {
    BlockedContactsView()
}
