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
    //공유 시트
    @State private var isSharingSheetPresented = false
    
    var body: some View {
        
        VStack{
            PartyInfoControllView()
            AddMemberProfileView(isSharingSheetPresented: $isSharingSheetPresented)
            
        }
        .padding(10)
//        .sheet(isPresented: $ismodiftyPartySheet){
//            MemberDetailSettingSheet(ismodiftyPartySheet: $ismodiftyPartySheet)
//        }
        .background(
            AppSharingSheet(
                isPresented: $isSharingSheetPresented,
                //아래는 테스트 주소, 앱 정보를 담은 링크를 보내야 함
                activityItems: [URL(string: "https://www.google.com")!]
            )
        )
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
            VStack{
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
                //2024.6.11 호스트 이름이 들어가야 함. (미작업)
                Text("별빛여우")
                    .foregroundStyle(.labelsPrimary)
            }
            
            VStack(alignment: .leading){
                HStack{
                    VStack(alignment: .leading){
                        //2024.6.11 작성한 파티 타이틀이 들어가야 함. (미작업)
                        Text("ex 제주도 파티")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.labelsPrimary)
                        //2024.6.11 선택한 날짜가 들어가야 함. (미작업)
                        Text("ex 2024.06.30")
                            .font(.callout)
                            .fontWeight(.regular)
                            .foregroundStyle(Color.labelsSecondary)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                       // ismodiftyPartySheet = true
                    }, label: {
                        Text("Edit")
                    })
                }
                Divider()
                //2024.6.11 파티 설명에서 입력한 내용이 들어가야 함. (미작업)
                DisclosureGroup("파티 설명", isExpanded: $isDescrExpanded){
                    TextEditor(text: $partyDescr )
                        .frame(height: 10)
                        .foregroundColor(Color.labelsSecondary)
                        .padding()
                }
                .frame(maxHeight: isDescrExpanded ? 100 : 0)
                Divider()
            }
        }
    }
}

struct AddMemberProfileView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    //공유 시트
    @Binding var isSharingSheetPresented: Bool
    @State private var profilebtns: [User] = []
    @State private var btncnt: Int = 0
    
    var body: some View{
        ScrollView{
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10)
            {
                Button(action: {
                    //시트가 나오고
                    //공유 링크가 나오고
                    isSharingSheetPresented = true
                    
                    //접속링크를 확인하고선 프로필을 추가 할 수 있도록 작업필요..
                    profilebtns.append(User(username: "New User\(btncnt)", usercolor: User.randomColor() ?? ".gray", isHost: false))
                    btncnt += 1
                    
                    //isActivityViewPresented = true
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
                            //융의님 나중에 채팅뷰로 이동하는 화면 확인해주세열
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
        }
    }
}
#Preview {
    MemberDetailView()
}
