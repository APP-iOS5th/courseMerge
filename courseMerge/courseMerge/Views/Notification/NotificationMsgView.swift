////
////  NotificationMessage.swift
////  CourseMerge
////
////  Created by Heeji Jung on 6/11/24.
////
//
//import SwiftUI
//
import SwiftUI

struct NotificationMsgView: View {
    let notifications = NotificationData.exampleNotification
    //@EnvironmentObject var notiViewModel: NotificationViewModel
    // var testidx: Int  = notiViewModel.notifiMsg.userProfileidx
    
    var body: some View {
        VStack{
            
            ForEach(notifications) { notis in
                //ForEach(notis) { notimsg in
                    NotificationCell(
                        partydatail: notis.party,
                        notifMsg: notis.msg,
                        sendmsgtime: notis.sendmsgtime
                    )
                //}
                .padding(.bottom, 10)
            }
        }.padding(20)

    }
}

struct NotificationCell: View{
    
    @Environment(\.colorScheme) var colorScheme
    var partydatail: PartyDetail
    var notifMsg: String
    var sendmsgtime: String
    
    //var partytitle: String
    //시간 코드수정 필요
    //var notitime: String
    
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
                Text(partydatail.title)
                    .fontWeight(.semibold)
                    .font(.title2)
                    .foregroundStyle(.labelsPrimary)
                    .padding(.leading,30)
                ProfileView(user: partydatail.members.first!, width: 25, height: 25, overlayWidth: 5, overlayHeight: 5, isUsername: false)
                Spacer()
                Text(sendmsgtime)
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
    NotificationMsgView()
}
