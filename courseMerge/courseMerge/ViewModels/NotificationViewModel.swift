//
//  NotificationViewModel.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/11/24.
//

import Foundation
class NotificationViewModel: ObservableObject {
    @Published var notifiMsg: [NotificationData] = []
    
    init() {
        // Sample data for demonstration
        
        notifiMsg = [
            NotificationData(partyTitle: "동두천 파티", userProfileidx: 1, datetime: "3분전", msg:"Host 가 함께 갈 메인 코스를 확정했습니다.확인해주세요."),
            NotificationData(partyTitle: "은평구 파티", userProfileidx: 2, datetime: "1시간 전", msg:"이융의님이 메시지를 보냈습니다."),
            NotificationData(partyTitle: "은평구 파티", userProfileidx: 3, datetime: "06/01", msg:"황규상님이 메시지를 보냈습니다.")
        ]
    }
}
