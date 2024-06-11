//
//  ChatView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/10/24.
//

import SwiftUI

// MARK: - ChatView

struct ChatView: View {
    let item: GroupPartyInfo
    @Environment(\.colorScheme) var colorScheme
    @State var exampleMessages: [Message] = Message.exampleMessages
    @State private var newMessage: String = ""
    
    var body: some View {
        VStack {
            // TODO: 메시지가 새로 올라올 경우, 아래로 스크롤 포커스
            ScrollView {
                LazyVStack {
                    // TODO: 내가 아닌 메시지 같은 사람이 연속으로 보낼 경우, profileImage, name 생략.
                    // 그리고 나 혹은 다른 사람이 연속으로 보낼 경우 메시지 간 간격 줄이기
                    ForEach(exampleMessages) { item in
                        
                        HStack(alignment: .top, spacing: 10) {
                            if !item.isCurrentUser {
                                
                                    // custom profile View
                                    Circle().fill(Color(item.member.usercolor))
                                        .stroke(Color(.separatorsNonOpaque), lineWidth: 1)
                                        .frame(width: 50, height: 50)
                                        .overlay {
                                            Image("ProfileMark")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 20, height: 20)
                                            
                                            if item.member.isHost {
                                                VStack {
                                                    Spacer()
                                                    HStack {
                                                        Spacer()
                                                        Image("custom.crown.circle.fill")
                                                    }
                                                }
                                            }
                                            // 호스트도 아닌 본인인 경우 추가
                                        }
                            } else {
                                Spacer()
                            }
                            MessageCell(contentMessage: item.content, isCurrentUser: item.isCurrentUser, member: item.member)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    }
                }
            }
            .background(colorScheme == .dark ? Color("BGSecondaryDarkElevated") : Color("BGSecondary"))
            .navigationTitle(item.title)
            .toolbarBackground(colorScheme == .dark ? Color("BGPrimaryDarkElevated") : Color("BGPrimary"), for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            
            Spacer()
            
            messageTextField
            
        }
    }
    
    // MARK: - messageTextField
    private var messageTextField: some View {
        HStack {
            TextField("메시지를 입력해주세요.", text: $newMessage)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(20)
                .overlay(
                    HStack {
                        Spacer()
                        if newMessage.isEmpty {
                            Image(systemName: "camera")
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                        }
                    }
                )
                .padding(.horizontal, 10)
            
            Button(action: {
                if !newMessage.isEmpty {
                    exampleMessages.append(Message(content: newMessage, isCurrentUser: true, member: User(username: "이융의", usercolor: "PastelBlue", isHost: false)))
                    newMessage = ""
                }
            }) {
                Image(systemName: "arrow.up.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
            }
            .padding(.trailing, 10)
        }
        .padding(.bottom, 10)
        .background(Color(UIColor.systemBackground))
    }
}


// MARK: - MessageCell

struct MessageCell: View {
    var contentMessage: String
    var isCurrentUser: Bool
    var member: User
    var body: some View {
        VStack(alignment: .leading) {
            if !isCurrentUser {
                Text(member.username)
                    .font(.footnote)
            }
            
            Text(contentMessage)
                .padding(10)
                .foregroundStyle(isCurrentUser ? Color.white : Color.black)
                .background(isCurrentUser ? Color.blue : Color("FillPrimary"))
                .roundedCorner(10, corners: isCurrentUser ? [.topLeft, .bottomLeft, .bottomRight] : [.topRight, .bottomLeft, .bottomRight])
        }
    }
}

#Preview {
    MessageCell(contentMessage: "This is a single message cell", isCurrentUser: true, member: User(username: "이융의", usercolor: "PastelBlue", isHost: false))
}

#Preview {
    NavigationStack {
        ChatView(item: GroupPartyInfo.exampleParties.first!, exampleMessages: Message.exampleMessages)
    }
}
