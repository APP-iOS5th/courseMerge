//
//  SettingView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/9/24.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        Form {
            Section {
                Text("Profile")
                Text("Blocked Contactcts")
            } header: {
                Text("General")
            }
            Section {
                Text("Privacy Policy")
                Text("Terms and Conditions")
                Text("Developers")
                Text("Report")
            } header: {
                Text("About")
            }
            Section {
                Text("Log out")
                Text("Sign out")
            } header: {
                Text("Account")
            }
        }
    }
}

#Preview {
    SettingView()
}
