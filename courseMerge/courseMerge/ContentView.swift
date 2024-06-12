//
//  ContentView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var partiesViewModel = PartyDetailsViewModel()
    @StateObject private var userViewModel = UserViewModel()
    
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        TabView {
            MemberView()
                .tabItem {
                    Label("구성원", systemImage: "person.fill")
                }
            ChatListView()
                .tabItem {
                    Label("채팅", systemImage: "message.fill")
                }
            MapView()
                .tabItem {
                    Label("지도", systemImage: "map.fill")
                }
            NotificationView()
                .tabItem {
                    Label("알림", systemImage: "bell.fill")
                }
            SettingView()
                .tabItem {
                    Label("설정", systemImage: "gearshape.fill")
                }
        }
        .environmentObject(userViewModel)
        .environmentObject(partiesViewModel)
        .environmentObject(authViewModel)

    }
}



