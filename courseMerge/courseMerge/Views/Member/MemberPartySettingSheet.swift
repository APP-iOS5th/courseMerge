//
//  MemberPartySettingSheet.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/10/24.
//

import SwiftUI

struct MemberPartySettingSheet: View {
    // 시트 작동을 위한 상태 변수
       @Environment(\.presentationMode) var presentMode
       
       //파티(모임) 제목 enumtype으로 빼기
       @State private var partytitle = "내용을 입력하세요.(필수)"
       //파티(모임) 설명  enumtype으로 빼기
       @State private var partyDescr = "내용을 입력하세요."
       
       var body: some View {
           NavigationView {
               VStack(alignment: .leading) { // 수직 스택을 왼쪽으로 정렬
                   Text("제목")
                       .font(.title3)
                       .fontWeight(.bold)
                       .padding(.top,20)
                   
                   TextField("내용을 입력하세요.(필수)", text: $partytitle)
                       .frame(width:  361, height: 65)
                       .background(.fillTertiary)
                       .cornerRadius(10)
                   
                   Text("설명")
                       .font(.title3)
                       .fontWeight(.bold)
                       .padding(.top,20)
                   
                   TextEditor(text: $partyDescr)
                       .frame(width:  361, height: 200)
                       .scrollContentBackground(.hidden)
                       .background(.fillTertiary)
                       .cornerRadius(10)
               }
               .padding(.horizontal) // 수직 스택의 좌우 여백 추가
               .navigationBarTitle("test", displayMode: .inline) // 타이틀을 숨기고
               .navigationBarItems(
                   leading: Button("Cancel") {
                       presentMode.wrappedValue.dismiss()
                   },
                   trailing: Button("Save") {
                       // 저장 작업을 수행하고 시트를 닫음
                       // 저장 작업을 여기에 추가
                       // 시트를 닫음
                       presentMode.wrappedValue.dismiss()
                   }
               )
           }
       }
   }

   #Preview {
       MemberPartySettingSheet()
   }
