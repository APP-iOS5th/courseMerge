//
//  UpdateProfileView.swift
//  CourseMerge
//
//  Created by mini on 6/10/24.
//

import SwiftUI

struct UpdateProfileView: View {
    @State var myColor = Color.red
    var body: some View {
        ColorPicker("select Color", selection: $myColor)
        Button("profile", systemImage: "pin") {
            
        }
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
