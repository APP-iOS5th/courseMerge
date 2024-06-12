//
//  AddPartySheetView.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/11/24.
//

import SwiftUI
// DatePicker 가 올라오면서, 텍스트가 위로 겹쳐보이기 때문에. sheet를 full screen cover 로 바꾸거나, datepicker 를 기본으로
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
    
    
    var body: some View {
        NavigationView {
            ScrollViewReader { targetproxy in
                VStack(alignment: .leading) {
                    
                    // Title
                    Text("제목")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top, 20)
        
                    TextField("제목을 입력하세요.(필수)", text: $partyTitle)
                        .padding(.leading, 10)
                        .foregroundColor(partyTitleColor)
                        .frame(width:  361, height: 65)
                        .background(.fillTertiary)
                        .cornerRadius(10)

                    if partyTitle.isEmpty {
                        Text("파티 제목을 입력해주세요 (필수)")
                            .foregroundColor(.red)
                            .padding(.leading, 10)
                    }
                    
                    // Description
                    Text("설명")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top,20)
                    
                    TextEditor(text: $partyDescr)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                        .frame(width:  361, height: 200)
                        .scrollContentBackground(.hidden)
                        .background(.fillTertiary)
                        .cornerRadius(10)
                        .foregroundColor(partyDescrColor)
                        .font(.system(size: 18))
                    
//                    AddDatePickerInputArea()
                    
                }
            }
            .padding(.horizontal)
            .navigationBarTitle("파티 추가", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
//                    memberDetailViewModel.savePartyData()
                    // 파이어베이스 스토리지에 저장
                    // 저장 작업을 수행하고 시트를 닫음
                    dismiss()
                }
            )
        }
    }
}
//
//struct AddDatePickerInputArea: View {
//    
//    @StateObject var vm = MemberDetailViewModel()
//    
//    //DatePicker 활성화 체크
//    @State private var activeDatePicker: EActiveDatePicker? = nil
//    
//    enum EActiveDatePicker {
//        case startDate
//        case endDate
//    }
//    
//    //Datepicer - startDate
//    @State private var showStartDatePicker = false
//    //Datepicer - EndDate
//    @State private var showEndDatePicker = false
//    
//    var body: some View{
//        ScrollViewReader{ targetproxy in
//            VStack{
//                HStack{
//                    Text("시작일")
//                        .padding(.top ,20)
//                    
//                    Spacer()
//                    
//                    Button("\(formatDate(vm.startDate))"){
//                        
//                        if activeDatePicker == .startDate {
//                            activeDatePicker = nil
//                        } else {
//                            activeDatePicker = .startDate
//                            targetproxy.scrollTo("startDatePicker", anchor: .center)
//                        }
//                    }
//                    .padding()
//                    .frame(width: 130, height: 35)
//                    .background(.fillTertiary)
//                    .cornerRadius(5)
//                    .padding(.top,20)
//                    .id("startDatePickerBtn")
//                    
//                }
//                
//                Divider()
//                
//                HStack{
//                    Text("종료일")
//                        .padding(.top ,20)
//                    
//                    Spacer()
//                    
//                    Button("\(formatDate(vm.endDate))"){
//                        
//                        if activeDatePicker == .endDate {
//                            activeDatePicker = nil
//                        } else {
//                            activeDatePicker = .endDate
//                            targetproxy.scrollTo("endDatePicker", anchor: .center)
//                        }
//                    }
//                    .padding()
//                    .frame(width: 130, height: 35)
//                    .background(.fillTertiary)
//                    .cornerRadius(5)
//                    .padding(.top,20)
//                    .id("endDatePickerBtn")
//                }
//            }
//            .padding(.leading,  5)
//        }
//        
//        
//        if activeDatePicker == .startDate  {
//            DatePicker("시작일",selection: $vm.startDate,displayedComponents: .date)
//                .datePickerStyle(.graphical)
//                .padding(20)
//                .id("startDatePicker")
//                .padding(.bottom, 70)
//        }
//        
//        if activeDatePicker == .endDate {
//            DatePicker("종료일",selection: $vm.endDate,displayedComponents: .date)
//                .datePickerStyle(.graphical)
//                .padding(20)
//                .id("endDatePicker")
//                .padding(.bottom, 70)
//        }
//        
//        
//        Spacer()
//    }
//    
//    
//    
//    private func formatDate(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMM dd,yyyy"
//        return formatter.string(from: date)
//    }
//}
//
//#Preview {
//    AddPartySheetView()
//}
