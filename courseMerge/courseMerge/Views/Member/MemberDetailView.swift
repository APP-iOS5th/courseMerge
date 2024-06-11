//
//  MemberView_withMembers.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/10/24.
//

import SwiftUI

/*
 TODO:
 0: 로그인할 때 - '본인'임을 구별할 수 있도록 User 모델에 추가?
 1. profile view - view builder
 2. members grid view
 3.
 */

//struct Profile: View {
//    var body: some View {
//        // custom profile View
//        Circle().fill(Color(item.member.usercolor))
//            .stroke(Color(.separatorsNonOpaque), lineWidth: 1)
//            .frame(width: 50, height: 50)
//            .overlay {
//                Image("ProfileMark")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 20, height: 20)
//                
//                if item.member.isHost {
//                    VStack {
//                        Spacer()
//                        HStack {
//                            Spacer()
//                            Image("custom.crown.circle.fill")
//                        }
//                    }
//                }
//                // 호스트도 아닌 본인인 경우 추가
//            }
//        
//    }
//}

struct MemberDetailView: View {
    
    @State private var createdParties: [GroupPartyInfo] = GroupPartyInfo.exampleParties
    @State private var isSharingSheetPresented = false
    
    var body: some View {
        
        VStack{
            PartyInfoControllView(createdParties: $createdParties)
            AddMemberProfileView()
        .padding(10)
        .sheet(isPresented: $isSharingSheetPresented){
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Sheet Content")/*@END_MENU_TOKEN@*/
        }
        
    }
}

struct PartyInfoControllView: View {
    @Binding var createdParties: [GroupPartyInfo]
    //뷰모델에서 데이터 가져오기
    
    @State private var partyDescr: String = "내용을 입력하세요."
    
    @State private var isDescrExpanded: Bool = false
    
    var body: some View{
        HStack{
            //샘플
            ZStack{
                Circle().fill(.pastelRed)
                    .frame(width: 100, height: 100)
                Image("ProfileMark")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
            }
            
            VStack(alignment: .leading){
                HStack{
                    VStack(alignment: .leading){
                        Text("ex 제주도 파티")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.labelsPrimary)
                        Text("ex 2024.06.30")
                            .font(.callout)
                            .fontWeight(.regular)
                            .foregroundStyle(Color.labelsSecondary)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Edit")
                    })
                }
                Divider()
                DisclosureGroup("파티 설명", isExpanded: $isDescrExpanded){
                    TextEditor(text: $partyDescr )
                        .frame(height: 10)
                        .foregroundColor(Color.labelsSecondary)
                        .padding()
                }
                .frame(maxHeight: isDescrExpanded ? 100 : 0)
                Divider()
            }
            .padding(.trailing, 10)
           
            
        }
    }
}

struct AddMemberProfileView: View {
    
    
    @State private var profilebtns: [User] = []
    
    var body: some View{
        ScrollView{
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10)
            {
                Button(action: {
                    //시트가 나오고
                    //공유 링크가 나오고
                    //접속 해야지 추가...
                    //
                    profilebtns.append(User(username: "New User", usercolor: ".pastelBlue", isHost:false))
                }, label: {
                    VStack{
                        ZStack{
                            Circle().fill(.bgSecondary)
                                .frame(width: 80, height: 80)
                            Image(systemName: "plus")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 30, height: 30)
                        }
                        Text("구성원 추가")
                            .foregroundStyle(.labelsPrimary)
                    }
                })
                
                ForEach(profilebtns) { index in
                    Button(action: {
                        
                    }, label: {
                        VStack{
                            ZStack{
                                //Circle().fill(Color("\(index.usercolor)")) //컬러 수정 필요
                                Circle().fill(.pastelBlue) //컬러 수정필요하다... 색을 못 읽어온다...
                                    .frame(width: 80, height: 80)
                                Image("ProfileMark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 30, height: 30)
                            }
                            Text("\(index.username)")
                                .foregroundStyle(.labelsPrimary)
                        }
                    })
                }
            }
        }}
    }
}

#Preview {
    MemberDetailView()
}
