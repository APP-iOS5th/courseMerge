//
//  NotificationView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI

struct NotificationView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var notiViewModel = NotificationViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                //클릭한 알림의 파티로 이동
                ScrollView{
                    NotificationMsgView()
                        .environmentObject(userViewModel)
                        .environmentObject(notiViewModel)
                }
            }
            .navigationTitle("알림")
            .background(colorScheme == .dark ? Color("BGPrimaryDarkBase") : Color("BGSecondary"))
        }
        
    }
}

#Preview {
    NotificationView()
}
