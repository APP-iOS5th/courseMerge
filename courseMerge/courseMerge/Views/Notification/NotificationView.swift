//
//  NotificationView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI

struct NotificationView: View {
    
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var notiViewModel = NotificationViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                //클릭한 알림의 파티로 이동
                NotificationMsgView()
                    .environmentObject(userViewModel)
                    .environmentObject(notiViewModel)
            }
            .navigationTitle("알림")
        }
        
    }
}

#Preview {
    NotificationView()
}
