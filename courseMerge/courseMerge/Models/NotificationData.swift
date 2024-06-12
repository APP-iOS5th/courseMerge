//
//  NotificationData.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/11/24.
//

import Foundation

struct NotificationData: Identifiable {
    //id?
    let id = UUID()
    var partyTitle: String
    var userProfileidx: Int
    var datetime: String
    var msg: String
}


