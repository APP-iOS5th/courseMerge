//
//  PartyViewModel.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/11/24.
//

import Foundation

class PartyViewModel: ObservableObject {
    @Published var parties: [GroupPartyInfo]
    
    init(parties: [GroupPartyInfo]) {
        self.parties = parties
    }
}
