//
//  GroupPartyItem.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/10/24.
//

import Foundation

struct GroupPartyInfo {
    let id: UUID
    var title: String
    var description: String
    var members: [User]
    var startdate: Date
    var enddate: Date
}

struct User{
    let id: UUID
    var username: String
    var usercolor: String
}
