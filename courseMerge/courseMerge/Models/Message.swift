//
//  Message.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/11/24.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    var content: String
    var isCurrentUser: Bool
    var member: User
}

extension Message {
    static let exampleMessages = [
        
        Message(content: "안녕!", isCurrentUser: true, member: User(username: "이융의", usercolor: "PastelBlue", isHost: false)),
        
        Message(content: "안녕! 추가 하시고 싶은 코스가 있으면 자유롭게 추가해줘~!", isCurrentUser: false, member: User(username: "황규상", usercolor: "PastelRed", isHost: true)),
        Message(content: "나는 여유로운 힐링 여행을 하고 싶어-!\n이 카페 먼저 갈까?", isCurrentUser: false, member: User(username: "정희지", usercolor: "PastelGreen", isHost: false)),
        Message(content: "오케이 알겠어요옹", isCurrentUser: true, member: User(username: "이융의", usercolor: "PastelBlue", isHost: false)),
        Message(content: "거기 디저트 맛있어요??.", isCurrentUser: true, member: User(username: "이융의", usercolor: "PastelBlue", isHost: false)),
        Message(content: "당연하지!", isCurrentUser: false, member: User(username: "정희지", usercolor: "PastelGreen", isHost: false)),
        Message(content: "어서와~~ 히히ㅣ", isCurrentUser: false, member: User(username: "정희지", usercolor: "PastelGreen", isHost: false)),
        Message(content: "The average distance from the Moon to the Earth is about 238,855 miles (384,400 kilometers). This distance can vary slightly because the Moon follows an elliptical orbit around the Earth, but the figure I mentioned is the average distance.", isCurrentUser: false, member: User(username: "조현기", usercolor: "PastelYellow", isHost: false))
      
    ]
}
