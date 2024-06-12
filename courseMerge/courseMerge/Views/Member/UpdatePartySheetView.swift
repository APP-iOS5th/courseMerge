////
////  UpdatePartySheetView.swift
////  CourseMerge
////
////  Created by Heeji Jung on 6/11/24.
////
//
//import SwiftUI
//
//struct UpdatePartySheetView: View {
//
//    @Environment(\.dismiss) var dismiss
//    
//    //뷰모델
//    @EnvironmentObject var partiesViewModel: PartyDetailsViewModel
//    
//    // 초기화할 때 필요한 속성들
//    @State private var partyTitle: String // TextField에서 사용할 party.title을 바인딩하기 위한 속성
//    @State private var partyDescription: String // TextField에서 사용할 party.description을 바인딩하기 위한 속성
//
//    // 생성자 수정
//    init(party: PartyDetail) {
//        _partyTitle = State(initialValue: party.title) // 초기값으로 파티의 제목을 설정
//        _partyDescription = State(initialValue: party.description) // 초기값으로 파티의 설명을 설정
//    }
//    
//    
//
//    //파티(모임) 제목 폰트 컬러
//    @State private var partyTitleColor: Color = .labelsTertiary
//    //파티(모임) 설명 폰트 컬러
//    @State private var partyDescrColor: Color = .labelsTertiary
//    
//    var body: some View {
//        NavigationView {
//            ScrollViewReader { targetproxy in
//                VStack(alignment: .leading) {
//
//                    Text("제목")
//                        .font(.title3)
//                        .fontWeight(.bold)
//                        .padding(.top,20)
//                    
//                    TextField("내용을 입력하세요.(필수)", text: $partyTitle)
//                        .frame(width:  361, height: 65)
//                        .background(.fillTertiary)
//                        .cornerRadius(10)
//                        .foregroundColor(partyTitleColor)
//                    
//                    if partyTitle.isEmpty {
//                        Text("파티 제목을 입력해주세요 (필수)")
//                            .foregroundColor(.red)
//                    }
//                    
//                    Text("설명")
//                        .font(.title3)
//                        .fontWeight(.bold)
//                        .padding(.top,20)
//                    
//                    
//                    TextEditor(text: $partyDescription)
//                        .frame(width:  361, height: 200)
//                        .scrollContentBackground(.hidden)
//                        .background(.fillTertiary)
//                        .cornerRadius(10)
//                        .foregroundColor(partyDescrColor)
//                    
////                    ModifyDatePickerInputArea()
//                    
//                }
//            }
//            .padding(.horizontal)
//            .navigationBarTitle("파티 수정", displayMode: .inline)
//            .navigationBarItems(
//                leading: Button("Cancel") {
//                    dismiss()
//                },
//                trailing: Button("Save") {
//                    // 저장 작업을 수행하고 시트를 닫음
////                    if let firstParty = memberDetailViewModel.createdPartInfo.first {
////                        if let index = memberDetailViewModel.createdPartInfo.firstIndex(where: { $0.title == firstParty.title }) {
////                            memberDetailViewModel.updatePartyData(atIndex: index)
////                        }
////                    }
//                    dismiss()
//                }
//            )
//        }
//    }
//}
////
////struct ModifyDatePickerInputArea: View {
////    
////    @StateObject var vm = MemberDetailViewModel
////    //DatePicker 활성화 체크
////    @State private var activeDatePicker: EActiveDatePicker? = nil
////    
////    enum EActiveDatePicker {
////        case startDate
////        case endDate
////    }
////    
////    //Datepicer - startDate
////    @State private var showStartDatePicker = false
////    //Datepicer - EndDate
////    @State private var showEndDatePicker = false
////    
////    var body: some View{
////        ScrollViewReader{ targetproxy in
////            VStack{
////                HStack{
////                    Text("시작일")
////                        .padding(.top ,20)
////                    
////                    Spacer()
////                    
////                    Button("\(formatDate(vm.startDate))"){
////                        
////                        if activeDatePicker == .startDate {
////                            activeDatePicker = nil
////                        } else {
////                            activeDatePicker = .startDate
////                            targetproxy.scrollTo("startDatePicker", anchor: .center)
////                        }
////                    }
////                    .padding()
////                    .frame(width: 130, height: 35)
////                    .background(.fillTertiary)
////                    .cornerRadius(5)
////                    .padding(.top,20)
////                    .id("startDatePickerBtn")
////                    
////                }
////                
////                Divider()
////                
////                HStack{
////                    Text("종료일")
////                        .padding(.top ,20)
////                    
////                    Spacer()
////                    
////                    Button("\(formatDate(vm.endDate))"){
////                        
////                        if activeDatePicker == .endDate {
////                            activeDatePicker = nil
////                        } else {
////                            activeDatePicker = .endDate
////                            targetproxy.scrollTo("endDatePicker", anchor: .center)
////                        }
////                    }
////                    .padding()
////                    .frame(width: 130, height: 35)
////                    .background(.fillTertiary)
////                    .cornerRadius(5)
////                    .padding(.top,20)
////                    .id("endDatePickerBtn")
////                }
////            }
////            .padding(.leading,  5)
////        }
////        
////        
////        if activeDatePicker == .startDate  {
////            DatePicker("시작일",selection:  $vm.startDate,displayedComponents: .date)
////                .datePickerStyle(.graphical)
////                .padding(20)
////                .id("startDatePicker")
////                .padding(.bottom, 70)
////        }
////        
////        if activeDatePicker == .endDate {
////            DatePicker("종료일",selection:  $vm.endDate,displayedComponents: .date)
////                .datePickerStyle(.graphical)
////                .padding(20)
////                .id("endDatePicker")
////                .padding(.bottom, 70)
////        }
////        
////        
////        Spacer()
////    }
////    
////    
////    
////    private func formatDate(_ date: Date) -> String {
////        let formatter = DateFormatter()
////        formatter.dateFormat = "MMM dd,yyyy"
////        return formatter.string(from: date)
////    }
////}
////
//////struct MemberProfileModifySheet: View {
//////    var body: some View {
//////        
//////        
//////    }
//////    
//////}
////#Preview {
////    UpdatePartySheetView()
////}
