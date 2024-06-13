//
//  UpdateProfileView.swift
//  CourseMerge
//
//  Created by mini on 6/10/24.
//

import SwiftUI

struct UpdateProfileView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let colors = ["pasteBlue", "pasteGreen", "pasteRed", "pasteYellow",]
    //컬러픽커에서 선택한 색상
    @State var selectedColor = Color.pastelBlue
    //프로필 이름
    @State var profileName: String = ""
    // 기존 사용자 이름
    @State private var excludeUsernames: [String] = []
    
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack {
            ZStack{
                Circle().fill(selectedColor)
                    .frame(width: 150, height: 150)
                Image("ProfileMark")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
               
            }
            HStack{
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
                        .foregroundColor(.fillPrimary)
                }
                
                
            }

            Divider()
            HStack {
                Button {
                    selectedColor = Color.pastelBlue
                } label: {
                    ZStack{
                        Circle().fill(.pastelBlue)
                            .frame(width: 80, height: 80)
                        Image("ProfileMark")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)

                    }
                }
                Button {
                    selectedColor = Color.pastelGreen
                } label: {
                    ZStack{
                        Circle().fill(.pastelGreen)
                            .frame(width: 80, height: 80)
                        Image("ProfileMark")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)

                    }
                }
                Button {
                    selectedColor = Color.pastelRed
                } label: {
                    ZStack{
                        Circle().fill(.pastelRed)
                            .frame(width: 80, height: 80)
                        Image("ProfileMark")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)

                    }
                }
                Button {
                    selectedColor = Color.pastelYellow
                } label: {
                    ZStack{
                        Circle().fill(.pastelYellow)
                            .frame(width: 80, height: 80)
                        Image("ProfileMark")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)

                    }
                }
            }
            .frame(height: 100)
            
            ZStack (alignment: .center) {
                Rectangle()
                    .foregroundStyle(.fillTertiary)
                    .frame(width: 200, height: 40)
                    .cornerRadius(10)
                ColorPicker("colorPicker", selection: $selectedColor)
                    .padding(120)
            }
            
            
            
            
        }//vstack
        .navigationTitle("프로필 변경")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("확인") {
                    //저장하기
                }
                
            }
        }
    }
}

#Preview {
    UpdateProfileView()
}
