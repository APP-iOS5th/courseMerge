//
//  BlockedData.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/13/24.
//

import Foundation


struct BlockedData: Identifiable {
    let id = UUID()
    var users: [User]
    var isblock: Bool
}

// Example Data
extension BlockedData {
    static var exampleBlocked: [BlockedData] = [
        BlockedData(users: [
            User(username: "갈색두더지", usercolor: "brown", isHost: false),
            User(username: "파랑공작새", usercolor: "Blue", isHost: false)
        ], isblock: true)
    ]
}
