//
//  ProfileView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/11/24.
//

import SwiftUI

struct ProfileView: View {
    var user: User
    var width: CGFloat
    var height: CGFloat
    var overlayWidth: CGFloat
    var overlayHeight: CGFloat
    var isUsername: Bool
    
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        VStack {
            // image
            Circle()
                .fill(Color(user.usercolor))
                .stroke(Color(.separatorsNonOpaque), lineWidth: 1)
                .frame(width: width, height: height)
                .overlay {
                    Image("ProfileMark")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: overlayWidth, height: overlayHeight)
                    
                    if user.isHost {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Image("custom.crown.circle.fill")
                                    
                            }
                        }
                    } else if user.uid == userViewModel.currentUserUID {
                        // host 일 경우에는 무조건 crown. 본인 경우에는 person. 그 외는 x
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Image("user_profil_mark")
                            }
                        }
                    }
                }
            
            // name
            if isUsername {
                Text(user.username)
                    .font(.callout)
                    .foregroundStyle(.labelsPrimary)
            }
        }
    }
}
