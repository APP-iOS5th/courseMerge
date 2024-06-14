//
//  PartyDetailsViewModel.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/11/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import AuthenticationServices
// Parties CRUD, current Party

class PartyDetailsViewModel: ObservableObject {
    @Published var parties: [PartyDetail] = []
    @Published var currentParty: PartyDetail?
    
    private var db = Firestore.firestore()

    init() {
        fetchParties()
    }
    
    // 파티 생성
    func addParty(_ party: PartyDetail) {
        do {
            var newParty = party
            let ref = try db.collection("parties").addDocument(from: newParty)
            newParty.docId = ref.documentID
            updateParty(newParty)
            self.currentParty = newParty // 새로운 파티로 변경
            fetchParties() // 새로 추가된 파티 목록을 불러옴
        } catch {
            print("Error writing party to Firestore: \(error.localizedDescription)")
        }
    }
    
    // 파티 체인지
    func changeParty(currentParty: PartyDetail, changedParty: PartyDetail) {
        if let currentPartyIndex = parties.firstIndex(where: { $0.id == currentParty.id }) {
            parties[currentPartyIndex] = changedParty
            self.currentParty = changedParty
            updateParty(changedParty)
        }
    }
    
    // 파티 목록 읽기

    func fetchParties() {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            print("Current user not found")
            return
        }
        
        db.collection("parties").addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting parties: \(error.localizedDescription)")
                return
            }
            
            let allParties = querySnapshot?.documents.compactMap { document in
                try? document.data(as: PartyDetail.self)
            } ?? []
            
            // 현재 사용자가 멤버로 포함된 파티만 필터링
            self.parties = allParties.filter { party in
                party.members.contains { $0.uid == currentUserUID }
            }
            
            // 파티 목록을 불러온 후 currentParty 설정
            if let firstParty = self.parties.first {
                self.currentParty = firstParty
            } else {
                self.currentParty = nil
            }
            
            print("Fetched parties: \(self.parties)")
            print("Current party: \(String(describing: self.currentParty))")
        }
    }
    
    
    // 파티 업데이트
    func updateParty(_ party: PartyDetail) {
        if let docId = party.docId {
            do {
                try db.collection("parties").document(docId).setData(from: party)
            } catch {
                print("Error updating party in Firestore: \(error.localizedDescription)")
            }
        }
    }
    
    // 파티 삭제
    func deleteParty(_ party: PartyDetail) {
        if let docId = party.docId {
            db.collection("parties").document(docId).delete { error in
                if let error = error {
                    print("Error removing party from Firestore: \(error.localizedDescription)")
                } else {
                    self.parties.removeAll { $0.id == party.id }
                    if self.currentParty?.id == party.id {
                        self.currentParty = self.parties.first
                    }
                }
            }
        }
    }
    
    // 호스트 확인
//    func isCurrentUserHost() -> Bool {
//        guard let currentUserUID = authViewModel.currentUserUID,
//              let currentParty = currentParty else {
//            return false
//        }
//        return currentParty.docId == currentUserUID
//    }
    
    //2024.06.13 에러로 인한 주석처리
    //TODO : 구성원 추가 에러 수정 필요
    /*func checkLoginFromTestLink() {
        //링크를 타고 왔을때, 애플로그인 혹은 게스트 로그인인지 구분 필요
        // 애플로그인으로 접속 했을때 currentuserid를 받는디
        // 호스트인지 아닌지 확인
        // 그리고 파티 정보를 담은 객체에 저장한다.
        // 게스트 로그인의 경우에는..?
        
        //애플로그인
        if authViewModel.isSignedIn {
            
            if let currentUserUID = authViewModel.currentUserUID
            {
                if isCurrentUserHost() {
                    
                    for party in parties {
                        do {
                            var newParty = party
                            newParty.members = party.members
                            addParty(newParty)
                        } catch {
                            print("Failed to add party: \(error.localizedDescription)")
                        }
                    }
                }
                
            }
            else
            {
                print("Failed to fetch current user UID:")
            }
        }else{
            
                //            //2024.06.14 코드 수정 해야 함
                //            if let error = authViewModel.error {
                //                // 인증오류
                //                print("로그인 과정에서 오류 발생: \(error.localizedDescription)")
                //            } else if{
                //                //사용자 로그인 취소
                //                print("알 수 없는 오류로 인해 로그인에 실패했습니다.")
                //            }
                //            else{
                //                print("게스트 로그인")
        }
    }*/
}
