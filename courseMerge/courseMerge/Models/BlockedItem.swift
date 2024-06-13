//
//  BlockedItem.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/12/24.
//

import Foundation

struct BlockedItem: Identifiable {
    var id = UUID()
    var users: [User]
    var isblock: Bool
}
