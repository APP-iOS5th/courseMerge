//
//  MemberView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI

struct MemberView: View {

    @StateObject private var memberDetailViewModel = MemberDetailViewModel()
    @Environment(\.colorScheme) var colorScheme
        
    var body: some View {
        NavigationView {
            VStack {
                
                if memberDetailViewModel.createdPartInfo.isEmpty
                {
                    MemberEmptyView(memberDetailViewModel: memberDetailViewModel)
                } else {
                    MemberHeaderView()
                    MemberDetailView(memberDetailViewModel: memberDetailViewModel)
                }
            }
        }
    }
}


struct MemberHeaderView: View {
    @State private var isShowSearchViewModal: Bool = false
    
    var body: some View {
        VStack {
            HStack{
                Text("구성원")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 52)
                
                //MemberPartySelecBtn()
            }
            Divider()
        }
        .sheet(isPresented: $isShowSearchViewModal) {
            SearchView()
        }
        .padding(.horizontal)
        .background(Color.white)
        
    }
}



#Preview {
    MemberView()
}
