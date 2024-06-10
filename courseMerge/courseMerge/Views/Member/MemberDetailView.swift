//
//  MemberView_withMembers.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/10/24.
//

import SwiftUI


struct MemberDetailView: View {
    
    @State private var createdParties: [GroupPartyInfo] = []
    @State private var profilebtns: [User] = []
    @State private var isSharingSheetPresented = false
    
    var body: some View {
        
        VStack{
            PartyInfoControllView()
            
            HStack(){
                
                Button(action: {
                    //시트가 나오고
                    //공유 링크가 나오고
                    //접속 해야지 추가...
                    //
                    profilebtns.append(User(username: "New User", usercolor: ".pastelGreen", isHost:false))
                }, label: {
                    VStack{
                        ZStack{
                            Circle().fill(.bgSecondary)
                                .frame(width: 100, height: 100)
                            Image(systemName: "plus")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                        }
                        Text("구성원 추가")
                            .foregroundStyle(.labelsPrimary)
                    }
                })
                
                ForEach(profilebtns, id: \.self) {index in
                    Button(action: {
                      
                    }, label: {
                        VStack{
                            ZStack{
                                Circle().fill(Color(index.usercolor)) //컬러 수정필요
                                    .frame(width: 100, height: 100)
                                Image("ProfileMark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                            }
                            Text("\(index.username)")
                                .foregroundStyle(.labelsPrimary)
                        }
                    })
                }
            }
           
        }
        .padding(10)
        .sheet(isPresented: $isSharingSheetPresented){
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Sheet Content")/*@END_MENU_TOKEN@*/
        }
        
    }
}

struct PartyInfoControllView: View {
   
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

#Preview {
    MemberDetailView()
}
