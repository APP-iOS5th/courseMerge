//
//  UpdateCourseView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/10/24.
//

import SwiftUI

struct UpdateCourseView: View {
    @State var showingSection = true
    var body: some View {
        VStack {
            /* ios 17 부터 가능!! -
             https://stackoverflow.com/questions/77266191/sidebar-list-style-in-swiftui-does-not-work
             */
        
            if #available(iOS 17.0, *) {
                List {
                    Section(isExpanded: $showingSection) {
                        Text("dfsdsd")
                    } header: {
                        VStack(alignment: .leading) {
                            Text("연남동 코스 끝내기")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(Color("LabelsPrimary"))
                            
                            Text("2024-06-01")
                                .font(.subheadline)
                                .foregroundStyle(Color("LabelsSecondary"))
                        }
                    }
                }
                .listStyle(.sidebar)
            }
        }
        .navigationTitle("코스 변경")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Text("Edit")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        UpdateCourseView()
    }
}
