//
//  UpdateProfileView.swift
//  CourseMerge
//
//  Created by mini on 6/10/24.
//

import SwiftUI

struct UpdateProfileView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Environment(\.dismiss) var dismiss

    @EnvironmentObject var authViewModel: AuthViewModel

    @State var profileName: String
    @State var selectedColor: String
    @State var uid: String
    @State var user: User
    
    @State private var excludeUsernames: [String] = []  // dev
    
    
    init(user: User) {
        _user = State(initialValue: user)
        _profileName = State(initialValue: user.username)
        _selectedColor = State(initialValue: user.usercolor)
        _uid = State(initialValue: user.uid ?? "")
    }
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)

    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack {
            ProfileView(user: user, width: 150, height: 150, overlayWidth: 50, overlayHeight: 50, isUsername: false)
                .environmentObject(authViewModel)
            
            profileNameField
            
            Divider()
            
//                colorGrid
        

            
        } // VStack
        .navigationTitle("프로필 변경")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("확인") {
                    guard let uid = authViewModel.currentUser?.uid else { return }
                    
                    authViewModel.updateUser(uid: uid, userName: profileName, userColor: selectedColor, isHost: authViewModel.currentUser?.isHost ?? false) { result in
                        switch result {
                        case .success:
                            dismiss()
                        case .failure(let error):
                            alertMessage = "프로필 업데이트 중 오류가 발생했습니다: \(error.localizedDescription)"
                            showAlert = true
                        }
                    }
                }
            }
        }
        .alert("알림", isPresented: $showAlert) {
            Button("확인") {
                showAlert = false
            }
        } message: {
            Text(alertMessage)
        }
    }
    
    var profileNameField: some View {
        HStack {
            TextField("프로필 이름", text: $profileName)
                .frame(width: 180, height: 40)
                .background(.fillTertiary)
                .font(.title3)
                .cornerRadius(10)
                .multilineTextAlignment(.center)
                .padding(.leading,30)
                .padding(.top)
                .padding(.bottom)
            
            
            Button(action: {
                let randomUsername = User.generateRandomUsername(excludeUsernames: excludeUsernames)
                
                profileName = randomUsername
            }) {
                Image(systemName: "shuffle.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
    }
    
//    var colorGrid: some view {
//        ScrollView {
//            LazyHGrid(columns: columns, spacing: 10) {
//                HStack {
//                    ForEach(User.hexColors) { color in
//                        Button {
//                            selectedColor = color
//                        } label: {
//                            ProfileView(user: User.exampleUsers.first!, width: 80, height: 80, overlayWidth: 40, overlayHeight: 40, isUsername: false)
//                        }
//                    }
//                }
//            }
//        }
//    }
    
//    var customColor: some View {
//        ZStack (alignment: .center) {
//            Rectangle()
//                .foregroundStyle(.fillTertiary)
//                .frame(width: 200, height: 40)
//                .cornerRadius(10)
//            ColorPicker("커스텀 컬러", selection: $selectedColor)
//                .padding(120)
//        }
//    }
}
//
//#Preview {
//    UpdateProfileView()
//        .environmentObject(AuthViewModel())
//}
