////
////  NotificationMessage.swift
////  CourseMerge
////
////  Created by Heeji Jung on 6/11/24.
////
//
//import SwiftUI
//
//struct NotificationMsgView: View {
//    @Environment(\.colorScheme) var colorScheme
//    @EnvironmentObject var userViewModel: UserViewModel
//    @EnvironmentObject var notiViewModel: NotificationViewModel
//   // var testidx: Int  = notiViewModel.notifiMsg.userProfileidx
//    
//    var body: some View {
//        VStack{
//            GeometryReader { geometry in
//                VStack{
//                    ForEach(notiViewModel.notifiMsg) { notimsg in
//                        ZStack{
//                            Rectangle()
//                                .fill(colorScheme == .dark ? Color("BGPrimaryDarkElevated") : Color("BGSecondary"))
//                                .frame(width: geometry.size.width, height: 190) // Rectangle의 너비만큼 설정
//                                .cornerRadius(10)
//                            VStack{
//                                HStack{
//                                    Text(notimsg.partyTitle)
//                                        .fontWeight(.semibold)
//                                        .font(.title)
//                                        .foregroundStyle(.labelsPrimary)
//                                        .padding(.leading)
//                                    //Spacer()
//                                    ProfileView(user: userViewModel.users[notimsg.userProfileidx], width: 25, height: 25, overlayWidth: 10, overlayHeight: 10, isUsername: false)
//                                    //Spacer()
//                                    Text(notimsg.datetime)
//                                        .fontWeight(.regular)
//                                        .font(.callout)
//                                        .foregroundStyle(.labelsTertiary)
//                                        .frame(maxWidth: .infinity)
//                                    
//                                }
//                                Text(notimsg.msg)
//                                   // .frame(maxWidth: .infinity)
//                            }
//                        }
//                    }
//                    .padding(.bottom, 10)
//                }
//            }
//        }
//        .padding(20)
//    }
//}
//
//#Preview {
//    NotificationMsgView()
//}
