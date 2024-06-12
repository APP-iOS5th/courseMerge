//
//  NotificationMessage.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/11/24.
//

import SwiftUI

struct NotificationMsgView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var notiViewModel: NotificationViewModel
    // var testidx: Int  = notiViewModel.notifiMsg.userProfileidx
    
    var body: some View {
        VStack{
            ForEach(notiViewModel.notifiMsg){ notimsg in
                NotificationCell(userViewModel:userViewModel ,partytitle: notimsg.partyTitle, notifMsg: notimsg.msg, notitime: notimsg.datetime,userProfileidx:notimsg.userProfileidx)
                    .padding(.bottom, 10)
            }
            
        }
        .padding(20)
    }
}

struct NotificationCell: View{
    
    @Environment(\.colorScheme) var colorScheme
    var userViewModel: UserViewModel
    var partytitle: String
    var notifMsg: String
    //시간 코드수정 필요
    var notitime: String
    var userProfileidx: Int
    
    var body: some View {
        VStack{
//            HStack {
//                Spacer()
//                Button(action: {
//                    // 닫기 버튼 액션
//                }) {
//                    Image(systemName: "xmark")
//                }
//                .padding(.trailing)
//            }.padding(.bottom,10)
            
            HStack{
                Text(partytitle)
                    .fontWeight(.semibold)
                    .font(.title2)
                    .foregroundStyle(.labelsPrimary)
                    .padding(.leading,30)
                ProfileView(user: userViewModel.users[userProfileidx], width: 25, height: 25, overlayWidth: 10, overlayHeight: 10, isUsername: false)
                Spacer()
                Text(notitime)
                    .fontWeight(.regular)
                    .font(.callout)
                    .foregroundStyle(.labelsTertiary)
                    .padding(.trailing,30)
                
            }
            .padding(.top, 10)
            
            Text(notifMsg)
                .font(.subheadline)
                .padding(.leading)
                .padding(.top, 5)
        }
        .frame(width: 350, height: 160)
        .background(colorScheme == .dark ? Color("BGPrimaryDarkElevated") : Color("BGSecondary"))
        .cornerRadius(10)
        .padding(.bottom, 20)
    }
    
}

#Preview {
    let userViewModel = UserViewModel()
     let notiViewModel = NotificationViewModel()
     return NotificationMsgView()
         .environmentObject(userViewModel)
         .environmentObject(notiViewModel)
}
