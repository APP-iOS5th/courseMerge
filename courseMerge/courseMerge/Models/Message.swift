//
//  Message.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/11/24.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    var content: String
    var isCurrentUser: Bool
    var member: User
    var party: PartyDetail
}
