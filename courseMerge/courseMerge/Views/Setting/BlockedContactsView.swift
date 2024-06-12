//
//  BlockedContactsView.swift
//  CourseMerge
//
//  Created by mini on 6/10/24.
//

import SwiftUI

struct BlockedContactsView: View {

    @State var blockedList: [BlockedItem] = [
            BlockedItem(users: [
                User(uid:"test1", username: "갈색두더지", usercolor: "brown", isHost: false),
                User(uid:"test2", username: "파랑공작새", usercolor: "Blue", isHost: false)
            ], isblock: true)
        ]
    
    @State var flag = false
    var body: some View {
        
        //NavigationStack {
        List {
            ForEach(blockedList) { item in
                ForEach(item.users) { blocked in
                    NavigationLink(value: blocked.username) {
                        HStack {
                            // 2024.6.12 uuid error
                            //ProfileView(user: blocked, width: 100, height: 100, overlayWidth: 30, overlayHeight: 50,isUsername: false)
               
                            Text(blocked.username)
                        }
                    }
                }
            }
            .onDelete { blockedList.remove(atOffsets: $0)}
            .onMove { blockedList.move(fromOffsets: $0, toOffset: $1)}
        }
        
//
//            }
//            .navigationDestination(for: String.self) { text in
//                Text("blocked item = \(text)")
//            }
//        }//NavigationStack
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
        .environmentObject(AuthViewModel())
}
