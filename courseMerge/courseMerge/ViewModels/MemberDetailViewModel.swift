//
//  MemberDetatilSettingViewModel.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/11/24.
//

import Foundation

class MemberDetailViewModel: ObservableObject {
    let userViewModel = UserViewModel()
    //파티(모임) 제목 enumtype으로 빼기
    @Published var partyTitle: String = " "
    //파티(모임) 설명  enumtype으로 빼기
    @Published var partyDescr: String = " "
    //시작일
    @Published var startDate = Date()
    //종료일
    @Published var endDate = Date()
    // 모임 멤버들
    @Published var members: [User] = []
    //파티(모임) 정보 저장
    @Published var createdPartInfo: [GroupPartyInfo] = []
    
    func savePartyData() {
        // 파이어베이스 스토리지에 저장
        guard !partyTitle.isEmpty else {
            print("Party title is required and cannot be empty")
            return
        }
        
        
        let newPartydata = GroupPartyInfo(title: partyTitle, description: partyDescr, members: userViewModel.users, startdate: startDate, enddate: endDate)
        createdPartInfo.append(newPartydata)
    }
    
    func updatePartyData(atIndex index: Int){
        
        //인덱스 유효 확인
        guard index >= -1 && index < createdPartInfo.count else {
            return
        }
        // 해당 인덱스에 있는 파티 정보를 업데이트
        createdPartInfo[index].title = partyTitle
        createdPartInfo[index].description = partyDescr
        createdPartInfo[index].members =  userViewModel.users
        createdPartInfo[index].startdate = startDate
        createdPartInfo[index].enddate = endDate
    }
    
}

