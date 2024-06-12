//
//  UpdatePartySheetView.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/11/24.
//

import SwiftUI

struct UpdatePartySheetView: View {

    @Environment(\.dismiss) var dismiss
    
    //뷰모델
    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel
    
    // 초기화할 때 필요한 속성들
    @State private var partyTitle: String // TextField에서 사용할 party.title을 바인딩하기 위한 속성
    @State private var partyDescr: String // TextField에서 사용할 party.description을 바인딩하기 위한 속성
    @State private var startDate: Date
    @State private var endDate: Date
    @State private var docId: String
    // 생성자 수정
    init(party: PartyDetail) {
        _partyTitle = State(initialValue: party.title) // 초기값으로 파티의 제목을 설정
        _partyDescr = State(initialValue: party.description) // 초기값으로 파티의 설명을 설정
        _startDate = State(initialValue: party.startdate)
        _endDate = State(initialValue: party.enddate)
        _docId = State(initialValue: party.docId ?? "")
        
    }
    
    //파티(모임) 제목 폰트 컬러
    @State private var partyTitleColor: Color = .labelsTertiary
    //파티(모임) 설명 폰트 컬러
    @State private var partyDescrColor: Color = .labelsTertiary
    
    @State private var showHelpText: Bool = false
    @State private var showDeleteConfirmation: Bool = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                // Title
                Text("제목")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                TextField("제목을 입력하세요.(필수)", text: $partyTitle)
                    .padding(.leading, 10)
//                    .foregroundColor(partyTitleColor)
                    .frame(width:  361, height: 65)
                    .background(.fillTertiary)
                    .cornerRadius(10)
                
                if showHelpText {
                    Text("파티 제목을 입력해주세요 (필수)")
                        .foregroundColor(.red)
                        .padding(.leading, 10)
                }
                
                // Description
                Text("설명")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                TextEditor(text: $partyDescr)
                    .padding(.leading, 10)
                    .padding(.top, 10)
                    .frame(width:  361, height: 200)
                    .scrollContentBackground(.hidden)
                    .background(.fillTertiary)
                    .cornerRadius(10)
//                    .foregroundColor(partyDescrColor)
                    .font(.system(size: 18))
                
                DatePicker("시작일", selection: $startDate, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .padding(10)
                    .cornerRadius(10)
                
                Divider()
                
                DatePicker("종료일", selection: $endDate, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .padding(10)
                    .cornerRadius(10)
                
                Spacer()
                
                // 삭제 버튼
                Button(action: {
                    showDeleteConfirmation = true
                }) {
                    Text("삭제하기")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .padding(.top)
                }
                .alert(isPresented: $showDeleteConfirmation) {
                    Alert(
                        title: Text("정말 삭제하시겠습니까?"),
                        message: Text("이 작업은 되돌릴 수 없습니다."),
                        primaryButton: .destructive(Text("삭제")) {
                            if let currentParty = partiesViewModel.currentParty {
                                partiesViewModel.deleteParty(currentParty)
                                dismiss()
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
                
            }
            .padding(.horizontal)
            .navigationBarTitle("파티 수정", displayMode: .inline)
            .navigationBarItems(
                leading: Button("취소") {
                    dismiss()
                },
                trailing: Button("저장") {
                    if partyTitle.isEmpty {
                        self.showHelpText = true
                    } else {
                        if let currentParty = partiesViewModel.currentParty {
                                     let updatedParty = PartyDetail(title: partyTitle, description: partyDescr, members: currentParty.members, startdate: startDate, enddate: endDate, docId: docId)
                                     partiesViewModel.updateParty(updatedParty)
                                     partiesViewModel.currentParty = updatedParty // 현재 파티로 변경
                                 }
                        dismiss()
                    }
                }
                    .foregroundColor(partyTitle.isEmpty ? .labelsTertiary : .blue) // Save 버튼 색상 설정
            )
        }
    }
}



#Preview {
    NavigationStack {
        UpdatePartySheetView(party: PartyDetail.exampleParty)
    }
}
