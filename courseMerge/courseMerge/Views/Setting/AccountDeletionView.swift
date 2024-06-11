//
//  AccountDeletionView.swift
//  CourseMerge
//
//  Created by mini on 6/10/24.
//

import SwiftUI

struct AccountDeletionView: View {
    @State var showAlert = false
    @State var flag = true
    
    var body: some View {
        VStack {
            
            Image(systemName: "smiley")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
            Text("코스머지 탈퇴 전 확인하세요")
            Text("탈퇴하시면 이용 중인 코스머지가 삭제되며, 모든 데이타는 복구가 불가능합니다.")
            ZStack{
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(height: 60)
                    .cornerRadius(10)
                VStack {
                    Text("모임, 코스, 프로필 등 모든 정보가 삭제됩니다")
                    Text("구성원과의 채팅은 삭제되지 않으니 미리 확인하세요")
                }
                
            }
            Text("blit list")
            Button("안내사항을 모두 확인하였으며, 이에 동의합니다.", systemImage: flag ? "checkmark.circle" : "checkmark.circle.fill") {
                    flag = false
            }
            
            Divider()
            Button("탈퇴하기") {
                showAlert = true
            }
            .buttonStyle(.borderedProminent)
            .disabled(flag)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("탈퇴하기"), dismissButton: .destructive(Text("확인")))
            }
        }
        .navigationTitle("회원탈퇴")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        
    }
}

#Preview {
    AccountDeletionView()
}
