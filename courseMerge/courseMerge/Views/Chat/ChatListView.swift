//
//  ChatListView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI

struct ChatListView: View {
    @State private var showNotification = false
    @State private var exampleParties = GroupPartyInfo.exampleParties
    @State private var isShowAlert: Bool = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(exampleParties) { item in
                         NavigationLink(destination: ChatView(item: item)) {
                             VStack(alignment: .leading) {
                                 Text(item.title)
                                     .font(.headline)
                                 
                                 if let firstMember = item.members.first {
                                     Text("\(firstMember.username) 외 \(item.members.count - 1)명")
                                         .font(.subheadline)
                                         .foregroundColor(Color("LabelsSecondary"))
                                 } else {
                                     Text("멤버 없음")
                                         .font(.subheadline)
                                         .foregroundColor(Color("LabelsSecondary"))
                                 }
                             }
                         }
                     }
                    .onDelete(perform: deleteItems)
                    .onMove(perform: moveItems)
                }
                .navigationTitle("채팅")
                .toolbar {
                    EditButton()
                }
                
                VStack {
                    // TODO: 앱 실행 후 한번만 나타나도록 하기!
                    if showNotification {
                        Text("채팅을 통해 파티원과 일정을 맞춰보세요!")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .transition(.move(edge: .top).combined(with: .opacity))
                            .animation(.easeInOut(duration: 0.5), value: showNotification)
                    }
                    Spacer()
                }
            }
            .onAppear {
                showNotificationWithDelay()
            }
            .alert("알림", isPresented: $isShowAlert) {
                Button("지금 안해요", role: .cancel) {
                    isShowAlert = false
                }
                Button {
                    
                } label: {
                    Text("추가")
                }
            } message: {
                Text("현재 참여중인 파티가 없습니다.\n파티를 추가하시겠어요?")
            }
        }
    }

    private func showNotificationWithDelay() {
        withAnimation {
            showNotification = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showNotification = false
            }
        }
    }
    private func deleteItems(at offsets: IndexSet) {
        exampleParties.remove(atOffsets: offsets)
    }
    
    private func moveItems(from source: IndexSet, to destination: Int) {
        exampleParties.move(fromOffsets: source, toOffset: destination)
    }
}

#Preview {
    ChatListView()
}
