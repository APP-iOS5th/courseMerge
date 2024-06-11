//
//  MemberView_withMembers.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/10/24.
//

import SwiftUI


struct MemberDetailView: View {
    
    @State private var isSharingSheetPresented = false
    
    var body: some View {
        
        VStack{
            PartyInfoControllView()
            AddMemberProfileView()
        .padding(25)
        .sheet(isPresented: $isSharingSheetPresented){
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Sheet Content")/*@END_MENU_TOKEN@*/
        }
        
    }
}

struct PartyInfoControllView: View {
   
    //뷰모델에서 데이터 가져오기
    @State private var partyDescr: String = "내용을 입력하세요."
    //설명 열고 닫기
    @State private var isDescrExpanded: Bool = false
    //호스트 표시
    var hasCrown: Bool = true
    
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
                if hasCrown {
                    Image(systemName: "crown.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .background(Color.yellow)
                        .clipShape(Circle())
                        .offset(x: 30, y: 35)
                }
                
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
           
            
        }.padding(10)
    }
}

struct AddMemberProfileView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var profilebtns: [User] = []
    @State private var btncnt: Int = 0
    
    
    var body: some View{
        ScrollView{
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10)
            {
                Button(action: {
                    //시트가 나오고
                    //공유 링크가 나오고
                    //접속 해야지 추가...
                    //
                    profilebtns.append(User(username: "New User\(btncnt)", usercolor: User.randomColor() ?? ".gray", isHost: false))
                    btncnt += 1
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
                
                ForEach(profilebtns, id: \.self) {index in
                    Button(action: {
                        
                    }, label: {
                        VStack{
                            ZStack{
                                //Circle().fill(Color(index.usercolor))
                                Circle().fill(Color.stringToColor((index.usercolor)))
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
                    .contextMenu{
                        Button(action:{
                            print("우리 말로 하자..")
                        }){
                            //융의님 나중에 여기 확인해주세열
                            NavigationLink(destination: EmptyView()){
                                Label("대화하기", systemImage: "message")
                                    .foregroundColor(.labelsPrimary)
                            }
                        }
                        Button(role: .destructive ,action:{
                            if let index = profilebtns.firstIndex(where: { $0.id == index.id }) {
                                profilebtns.remove(at: index)
                            }
                            print("\(index.username) 아쉽지만 나가라... 삭제 완 ><")
                        }){
                            Label("삭제하기", systemImage: "trash")
                        }
                    }
                }
            }
        }}
    }
}

#Preview {
    MemberDetailView()
}
