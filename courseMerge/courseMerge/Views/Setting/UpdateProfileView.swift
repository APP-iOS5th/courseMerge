//
//  UpdateProfileView.swift
//  CourseMerge
//
//  Created by mini on 6/10/24.
//

import SwiftUI

struct UpdateProfileView: View {
    let colors = ["pasteBlue", "pasteGreen", "pasteRed", "pasteYellow",]
    @State var selectedColor = Color.pastelBlue
    
    var body: some View {
        VStack {
            ZStack{
                Circle().fill(selectedColor)
                    .frame(width: 200, height: 200)
                Image("ProfileMark")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)

            }
            ZStack{
                Rectangle()
                    .foregroundStyle(.fillTertiary)
                    .frame(width: 200, height: 40)
                    .cornerRadius(10)
                VStack(alignment:.leading) {
                    Text("프로필 이름")
                        .font(.title3)
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
            
            ZStack (alignment: .center){
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
                    
                }
                
            }
        }
    }
}

#Preview {
    UpdateProfileView()
}
