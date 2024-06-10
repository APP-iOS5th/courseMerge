//
//  MemberView_withMembers.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/10/24.
//

import SwiftUI

struct MemberView_withMembers: View {
    
    var body: some View {
        
        //샘플
        ZStack{
            Circle().fill(Color.blue) // 채우고 싶은 색상
            .frame(width: 200, height: 200)
            Image("ProfileMark")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
           
        }
       
                      
        
    }
}

#Preview {
    MemberView_withMembers()
}
