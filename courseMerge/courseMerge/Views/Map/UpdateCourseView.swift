//
//  UpdateCourseView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/10/24.
//

import SwiftUI

struct UpdateCourseView: View {
    @State private var expandedSections: Set<UUID> = []
    let descriptionSample = CourseDescription.example
    @State private var selectedItem: MapDetailItem?
    
    @State private var searchText: String = ""

    var body: some View {
        VStack {
            /* ios 17 부터 가능!! -
             https://stackoverflow.com/questions/77266191/sidebar-list-style-in-swiftui-does-not-work
             */
        
            if #available(iOS 17.0, *) {
                List {
                    ForEach(descriptionSample) { sample in
                        Section(isExpanded: Binding(
                            get: { expandedSections.contains(sample.id) },
                            set: { isExpanded in
                                if isExpanded {
                                    expandedSections.insert(sample.id)
                                } else {
                                    expandedSections.remove(sample.id)
                                }
                            }
                        )) {
                            ForEach(sample.items) { item in
                                VStack {
                                    Button {
                                        selectedItem = item
                                    } label: {
                                        ItemRow(item: item)
                                    }
                                }
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    
                                } label: {
                                    Label("삭제", systemImage: "trash")
                                }
                            }
                        } header: {
                            VStack(alignment: .leading) {
                                Text(sample.description)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color("LabelsPrimary"))
                                
                                Text(sample.formattedDate)
                                    .font(.subheadline)
                                    .foregroundStyle(Color("LabelsSecondary"))
                            }
                        }
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))

                .listStyle(.sidebar)
            }
        }
        .sheet(item: $selectedItem) { item in
            SearchResultDetailView(item: item, isFirstCourse: .constant(false), isEdit: .constant(true))
                .presentationDetents([.fraction(0.6), .fraction(0.75)])
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
