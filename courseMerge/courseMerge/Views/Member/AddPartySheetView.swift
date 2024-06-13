//
//  AddPartySheetView.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/11/24.
//

import SwiftUI

struct AddPartySheetView: View {
    @Environment(\.dismiss) var dismiss
    
    //파티(모임) 제목 폰트 컬러
    @State private var partyTitleColor: Color = .labelsTertiary
    //파티(모임) 설명 폰트 컬러
    @State private var partyDescrColor: Color = .labelsTertiary
    
    // Published 프로퍼티 래퍼보다는 @State
    @State private var partyTitle: String = ""
    @State private var partyDescr: String = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    
    // viewModel
    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel
    @EnvironmentObject var authViewModel: AuthViewModel

    @State private var showHelpText: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                // Title
                Text("파티명")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                TextField("파티명을 입력하세요. (필수)", text: $partyTitle)
                    .padding(.leading, 10)
//                    .foregroundColor(partyTitleColor)
                    .frame(width:  361, height: 65)
                    .background(.fillTertiary)
                    .cornerRadius(10)
                
                if showHelpText {
                    Text("파티 제목을 입력하세요. (필수)")
                        .foregroundColor(.red)
                        .padding(.leading, 10)
                }
                
                // Description
                Text("설명")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                ZStack(alignment: .topLeading) {
                    if partyDescr.isEmpty {
                        Text("파티에 대한 설명을 입력하세요.")
                            .foregroundStyle(partyDescrColor)
                            .padding(.leading, 14)
                            .padding(.top, 18)
                            .font(.system(size: 18))
                    }
                    
                    TextEditor(text: $partyDescr)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                        .frame(width: 361, height: 200)
                        .scrollContentBackground(.hidden)
                        .background(.fillTertiary)
                        .cornerRadius(10)
                        .font(.system(size: 18))
                        .onChange(of: partyDescr) { _, newValue in
                            partyDescrColor = newValue.isEmpty ? .labelsTertiary : .labelsPrimary
                        }
                        .foregroundStyle(partyDescrColor)
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                        }
                }
                
                DatePicker("시작일", selection: $startDate, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .padding(10)
                    .cornerRadius(10)
                
                Divider()
                
                DatePicker("종료일", selection: $endDate, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .padding(10)
                    .cornerRadius(10)
                
            }
            .padding(.horizontal)
            .navigationBarTitle("파티 추가", displayMode: .inline)
            .navigationBarItems(
                leading: Button("취소") {
                    dismiss()
                },
                trailing: Button("저장") {
                    if partyTitle.isEmpty {
                        self.showHelpText = true
                    } else {
                        
                        if partiesViewModel.currentParty == nil {
                            if let currentUser = authViewModel.currentUser {
                                var hostUser = currentUser
                                hostUser.isHost = true
                                
                                let newParty = PartyDetail(title: partyTitle, description: partyDescr, members: [hostUser], startdate: startDate, enddate: endDate)
                                
                                partiesViewModel.addParty(newParty)
                                
                                dismiss()
                            }
                        } else {
                            if let currentUser = authViewModel.currentUser, let currentParty = partiesViewModel.currentParty {
                                
                                var hostUser = currentUser
                                hostUser.isHost = true
                                
                                let newParty = PartyDetail(title: partyTitle, description: partyDescr, members: [hostUser], startdate: startDate, enddate: endDate)
                                partiesViewModel.addParty(newParty)
                                
                                // 추가한 파티로 이동
                                partiesViewModel.currentParty = newParty
                                
                                dismiss()

                            }
                        }

                    }
                }
                    .foregroundColor(partyTitle.isEmpty ? .labelsTertiary : .blue) // Save 버튼 색상 설정
            )
        }
    }
}

#Preview {
    AddPartySheetView()
        .environmentObject(PartyDetailsViewModel())
}
