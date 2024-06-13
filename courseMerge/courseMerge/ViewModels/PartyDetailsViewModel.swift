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
    private var authViewModel: AuthViewModel
    private var session: ASWebAuthenticationSession?
    
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
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
        guard let currentUserUID = authViewModel.currentUserUID else {
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
    
    //2024.06.13
    func checkLoginFromTestLink() {
        //링크를 타고 왔을때, 애플로그인 혹은 게스트 로그인인지 구분 필요
        // 애플로그인으로 접속 했을때 currentuserid를 받는디
        // 그리고 파티 정보를 담은 객체에 저장한다.
        // 게스트 로그인의 경우에는..?
        // 호스트 기준으로 방을 알려준다..?
        
        //애플로그인
        if authViewModel.isSignedIn {
            
            if let currentUserUID = authViewModel.currentUserUID {
                // 성공적으로 UID를 가져왔을 때 실행할 코드
                for i in parties.indices {
                    parties[i].docId = currentUserUID
                    do {
                        try addParty(parties[i])
                    } catch {
                        print("Failed to add party: \(error.localizedDescription)")
                    }
                }
            } else {
                
                print("Failed to fetch current user UID:")
                
                // currentUserUID가 nil인 경우, UID를 비동기적으로 가져옴
//                authViewModel.fetchCurrentUserUID { [weak self] result in
//                    guard let self = self else { return }
//                    
//                    switch result {
//                    case .success(let currentUserUID):
//                        self.parties.forEach { party in
//                            party.docId = currentUserUID
//                        }
//                        do {
//                            try self.addParty(PartyDetail.self)
//                        } catch {
//                            print("Failed to add party: \(error.localizedDescription)")
//                        }
//                    case .failure(let error):
//                        print("Failed to fetch current user UID: \(error.localizedDescription)")
//                    }
//                }
            }
        } else {
            //게스트 로그인
        }
    }
}

//
//    
//    // MARK: - Sample
//    private static func loadExampleSingleData() -> PartyDetail {
//        PartyDetail(
//            title: "제주도 파티",
//            description: "이것은 매우 긴 설명입니다. iOS 앱스쿨 5기에서 우리는 파티를 즐기기 위해 제주도에 갑니다. 이 파티는 매우 특별하며, 다양한 활동과 이벤트가 계획되어 있습니다. 모든 멤버는 즐거운 시간을 보낼 것입니다. 이 설명은 예제 텍스트로서 매우 길게 작성되었습니다.",
//            members: User.exampleUsers,
//            startdate: Date(),
//            enddate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!
//        )
//    }
//    
//    private static func loadExampleData() -> [PartyDetail] {
//        return [
//            PartyDetail(
//                title: "제주도 파티",
//                description: "iOS 앱스쿨 5기",
//                members: User.exampleUsers,
//                startdate: Date(),
//                enddate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!
//            ),
//            PartyDetail(
//                title: "동두천 파티",
//                description: "iOS 앱스쿨 5기",
//                members: User.exampleUsers,
//                startdate: Date(),
//                enddate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!
//            ),
//            PartyDetail(
//                title: "은평구 파티",
//                description: "iOS 앱스쿨 5기",
//                members: User.exampleUsers,
//                startdate: Date(),
//                enddate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!
//            )
//        ]
//    }
//}
