//
//  BlockedContactsView.swift
//  CourseMerge
//
//  Created by mini on 6/10/24.
//

import SwiftUI

struct BlockedContactsView: View {
    //
    //    var body: some View {
    //        Text("차단한 사용자 관리")
    //            .navigationTitle("차단한 사용자 관리")
    //            .navigationBarTitleDisplayMode(.inline)
    //
    //
    //    }
    //}

    
    @State var flag = false
    var body: some View {
        
        let user1 = User.exampleUsers[0]
        //NavigationStack {
        List {
            ForEach(BlockedData.exampleBlocked) { item in
                ForEach(item.users) { blocked in
                    NavigationLink(value: blocked.username) {
                        HStack {
                            // 2024.61uuid error
                           ProfileView(user: blocked, width: 40, height: 40, overlayWidth: 15, overlayHeight: 15,isUsername: false)
                            
                            Text(blocked.username)
                        }
                    }
                }
            }
//            .onDelete { BlockedData.remove(atOffsets: $0)}
//            .onMove { BlockedData.move(fromOffsets: $0, toOffset: $1)}
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
