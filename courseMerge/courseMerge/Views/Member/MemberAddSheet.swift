//
//  MemberAddSheet.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/11/24.
//

import SwiftUI

struct MemberAddSheet: View {
    @Environment(\.presentationMode) var presentMode
    
    @EnvironmentObject var memberDetailViewModel: MemberDetailViewModel
    //파티(모임) 제목 폰트 컬러
    @State private var partyTitleColor: Color = .labelsTertiary
    //파티(모임) 설명 폰트 컬러
    @State private var partyDescrColor: Color = .labelsTertiary
    @State private var titleTextEditor: String = ""
    @State private var descriptionTextEditor: String = ""
    
    
    var body: some View {
        NavigationView {
            ScrollViewReader { targetproxy in
                VStack(alignment: .leading) {
                    Text("제목")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top,20)
        
                    TextField("", text: $titleTextEditor)
                        .padding(.leading, 10)
                        .overlay(alignment: .topLeading) {
                            Text("Placeholder")
                                .foregroundStyle(titleTextEditor.isEmpty ? partyTitleColor : .clear)
                                .padding(.leading, 10)
                                .font(.system(size: 18))
                        }
                        .foregroundColor(partyTitleColor)
                        .frame(width:  361, height: 65)
                        .background(.fillTertiary)
                        .cornerRadius(10)
                        .onChange(of: titleTextEditor) { _, newValue in
                            partyTitleColor = newValue.isEmpty ? .labelsTertiary : .labelsPrimary
                        }
                        .font(.system(size: 18))

                    if memberDetailViewModel.partytitle.isEmpty {
                        Text("파티 제목을 입력해주세요 (필수)")
                            .foregroundColor(.red)
                    }
                    
                    
                    Text("설명")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top,20)
                    
                    TextEditor(text: $descriptionTextEditor)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                        .overlay(alignment: .topLeading) {
                            Text("Placeholder")
                                .foregroundStyle(descriptionTextEditor.isEmpty ? partyDescrColor : .clear)
                                .padding(.leading, 12)
                                .padding(.top, 18)
                                .font(.system(size: 18))
                        }
                        .frame(width:  361, height: 200)
                        .scrollContentBackground(.hidden)
                        .background(.fillTertiary)
                        .cornerRadius(10)
                        .onChange(of: descriptionTextEditor) { _, newValue1 in
                            partyDescrColor = newValue1.isEmpty ? .labelsPrimary : .labelsPrimary
                        }
                        .foregroundColor(partyDescrColor)
                        .font(.system(size: 18))
                    
                    AddDatePickerInputArea(vm: memberDetailViewModel)
                    
                }
            }
            .padding(.horizontal)
            .navigationBarTitle("파티 추가", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    memberDetailViewModel.savePartyData()
                    // 파이어베이스 스토리지에 저장
                    // 저장 작업을 수행하고 시트를 닫음
                    presentMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct AddDatePickerInputArea: View {
    
    @ObservedObject var vm: MemberDetailViewModel
    
    //DatePicker 활성화 체크
    @State private var activeDatePicker: EActiveDatePicker? = nil
    
    enum EActiveDatePicker {
        case startDate
        case endDate
    }
    
    //Datepicer - startDate
    @State private var showStartDatePicker = false
    //Datepicer - EndDate
    @State private var showEndDatePicker = false
    
    var body: some View{
        ScrollViewReader{ targetproxy in
            VStack{
                HStack{
                    Text("시작일")
                        .padding(.top ,20)
                    
                    Spacer()
                    
                    Button("\(formatDate(vm.startDate))"){
                        
                        if activeDatePicker == .startDate {
                            activeDatePicker = nil
                        } else {
                            activeDatePicker = .startDate
                            targetproxy.scrollTo("startDatePicker", anchor: .center)
                        }
                    }
                    .padding()
                    .frame(width: 130, height: 35)
                    .background(.fillTertiary)
                    .cornerRadius(5)
                    .padding(.top,20)
                    .id("startDatePickerBtn")
                    
                }
                
                Divider()
                
                HStack{
                    Text("종료일")
                        .padding(.top ,20)
                    
                    Spacer()
                    
                    Button("\(formatDate(vm.endDate))"){
                        
                        if activeDatePicker == .endDate {
                            activeDatePicker = nil
                        } else {
                            activeDatePicker = .endDate
                            targetproxy.scrollTo("endDatePicker", anchor: .center)
                        }
                    }
                    .padding()
                    .frame(width: 130, height: 35)
                    .background(.fillTertiary)
                    .cornerRadius(5)
                    .padding(.top,20)
                    .id("endDatePickerBtn")
                }
            }
            .padding(.leading,  5)
        }
        
        
        if activeDatePicker == .startDate  {
            DatePicker("시작일",selection: $vm.startDate,displayedComponents: .date)
                .datePickerStyle(.graphical)
                .padding(20)
                .id("startDatePicker")
                .padding(.bottom, 70)
        }
        
        if activeDatePicker == .endDate {
            DatePicker("종료일",selection: $vm.endDate,displayedComponents: .date)
                .datePickerStyle(.graphical)
                .padding(20)
                .id("endDatePicker")
                .padding(.bottom, 70)
        }
        
        
        Spacer()
    }
    
    
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd,yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    MemberAddSheet().environmentObject(MemberDetailViewModel())
    
        

}
