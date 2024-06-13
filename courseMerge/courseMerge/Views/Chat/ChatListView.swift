//
//  ChatListView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI

struct ChatListView: View {
    @State private var showNotification = false
    @State private var isShowAlert: Bool = false
    @State private var showLoginAlert: Bool = false
    
    @State private var showingAddPartySheetView = false

    // viewModel
    @StateObject var messagesViewModel = MessageViewModel()
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(partiesViewModel.parties) { party in
                        NavigationLink(
                            destination: ChatView(party: party)
                                .environmentObject(authViewModel)
                                .environmentObject(partiesViewModel)
                                .environmentObject(messagesViewModel)
                            
                        ) {
                             VStack(alignment: .leading) {
                                 Text(party.title)
                                     .font(.headline)
                                 
                                 if let firstMember = party.members.first {
                                     Text("\(firstMember.username) 외 \(party.members.count - 1)명")
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
//                    .onDelete(perform: deleteItems)
//                    .onMove(perform: moveItems)
                }
                .navigationTitle("채팅")
                .toolbar {
                    EditButton()
                        .disabled(!authViewModel.isSignedIn)
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
//                            .offset(y: -40)
                    }
                    Spacer()
                }
            }
            .sheet(isPresented: $showingAddPartySheetView) {
                AddPartySheetView()
                    .environmentObject(authViewModel)
                    .environmentObject(partiesViewModel)
            }
            .onAppear {
                showNotificationWithDelay()
                checkStatus()
            }
            .alert("알림", isPresented: $isShowAlert) {
                Button("지금 안해요", role: .cancel) {
                    isShowAlert = false
                }
                Button {
                    showingAddPartySheetView = true
                } label: {
                    Text("추가")
                }
            } message: {
                Text("현재 참여중인 파티가 없습니다.\n파티를 추가하시겠어요?")
            }
            .alert("로그인이 필요합니다.", isPresented: $showLoginAlert) {
                Button("취소", role: .cancel) {
                    showLoginAlert = false
                }
                Button("확인") {
                    authViewModel.isSignedIn = false
                    authViewModel.goToLoginView = true
                }
            } message: {
                Text("로그인 후 파티에 참여하여 이야기를 나누어 보세요.")
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
    
    private func checkStatus() {
        if authViewModel.isSignedIn {   // 로그인 했을때
            if partiesViewModel.parties.isEmpty {   // 파티가 없을 때
                self.isShowAlert = true
            }
        } else { // 로그인 안했을 때
            self.showLoginAlert = true
        }

    }
    private func deleteItems(at offsets: IndexSet) {
        partiesViewModel.parties.remove(atOffsets: offsets)
    }
    
    private func moveItems(from source: IndexSet, to destination: Int) {
        partiesViewModel.parties.move(fromOffsets: source, toOffset: destination)
    }
}

#Preview {
    ChatListView()
}
