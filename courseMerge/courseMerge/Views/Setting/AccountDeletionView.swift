//
//  AccountDeletionView.swift
//  CourseMerge
//
//  Created by mini on 6/10/24.
//

import SwiftUI

struct AccountDeletionView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var showAlert = false
    @State var flag = true
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack(alignment:.center) {
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .padding()

            Text("코스머지 탈퇴 전 확인하세요")
                .font(.title)
                .bold()

            Text("탈퇴하시면 이용 중인 코스머지가 삭제되며, \n모든 데이타는 복구가 불가능합니다.")
                .foregroundStyle(.pastelRed)
                .multilineTextAlignment(.center)
                .padding(.top,1)
            //Spacer(minLength: 10)
            ZStack{
                Rectangle()
                    .foregroundStyle(.bgSecondary)
                    .frame(height: 80)
                    .cornerRadius(10)
                VStack(alignment:.leading) {
                    Text("･ 모임, 코스, 프로필 등 모든 정보가 삭제됩니다")
                        .foregroundStyle(.black)
                    Text("･ 구성원과의 채팅은 삭제되지 않으니 미리 확인하세요")
                        .foregroundStyle(.black)
                }
                .font(.subheadline)
            }
            .padding(.top,15)
            Spacer()
            Button("안내사항을 모두 확인하였으며, 이에 동의합니다.", systemImage: flag ? "checkmark.circle" : "checkmark.circle.fill") {
                flag.toggle()
            }
            
            Divider()
            Spacer()
            Button("탈퇴하기") {
                showAlert = true
            }
            .buttonStyle(.borderedProminent)
            .disabled(flag)
            .alert("알림", isPresented: $showAlert) {
                Button("취소", role: .cancel) {
                    showAlert = false
                }
                Button(role: .destructive) {
                    authViewModel.deleteUser { result in
                        switch result {
                        case .success:
                            print("successfully user deleted")
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                } label: {
                    Text("확인")
                }
            } message: {
                Text("정말로 회원탈퇴 하시겠습니까?")
            }
        }
        .navigationTitle("회원탈퇴")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        Spacer()
    }
}

#Preview {
    AccountDeletionView()
}
