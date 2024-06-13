//
//  NotificationData.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/11/24.
//

import Foundation

struct NotificationData: Identifiable {
    let id = UUID()
    var party: PartyDetail
    var msg: String
    var sendmsgtime: String
    //var user 데이터
}

// Example Data

extension NotificationData {
    static var exampleNotification: [NotificationData] = [
        NotificationData(party: PartyDetail.exampleParty, msg:"Host 가 함께 갈 메인 코스를 확정했습니다.\n확인해주세요.", sendmsgtime: "5분전"),
        NotificationData(party: PartyDetail.exampleParty, msg:"이융의님이 메시지를 보냈습니다.",sendmsgtime: "1시간 전"),
        NotificationData(party: PartyDetail.exampleParty, msg:"황규상님이 메시지를 보냈습니다.",sendmsgtime: "30분 전")
    ]
}


