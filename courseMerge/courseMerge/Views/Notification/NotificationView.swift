//
//  NotificationView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI

struct NotificationView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
//    @StateObject private var notiViewModel = NotificationViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                //클릭한 알림의 파티로 이동
//                ScrollView{
//                    NotificationMsgView()
//                        .environmentObject(userViewModel)
//                        .environmentObject(notiViewModel)
//                }
            }
            .navigationTitle("알림")
            .background(colorScheme == .dark ? Color("BGPrimaryDarkBase") : Color("BGPrimary"))
        }
        
    }
}

#Preview {
    NotificationView()
}
