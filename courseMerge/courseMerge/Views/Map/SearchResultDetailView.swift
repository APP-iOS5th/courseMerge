//
//  SearchResultDetailView.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/10/24.
//

import SwiftUI

// MARK: - SearchResultDetailView

struct SearchResultDetailView: View {
    let item: MapDetailItem
    
    @State private var isFavorite: Bool = true
    
    @State private var firstCourseText: String = ""
    @Binding var isFirstCourse: Bool
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme

    // TODO: 신고하기 버튼 추가
    
    var body: some View {
        NavigationStack {
            VStack {
                // Title
                HStack {
                    Text(item.name ?? "No Name")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Button {
                        isFavorite.toggle()
                    } label: {
                        Image(systemName: "star.fill")
                            .font(.title)
                            .foregroundStyle(isFavorite ? Color("PastelYellow") : Color("FillPrimary"))
                    }
                    .padding(.bottom, 5)
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundStyle(Color("FillPrimary"))
                    }
                    .padding(.bottom, 5)
                }
                .padding(.top, 10)
                .padding(20)
                
                
                // Category
                HStack {
                    if let symbol = item.category?.symbol {
                        Image(systemName: symbol)
                            .font(.title)
                            .foregroundStyle(.blue)
                    } else if let customImage = item.category?.customImage {
                        customImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    
                    Text(item.category?.rawValue ?? "No value")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundStyle(Color("LabelsSecondary"))
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                // datail
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text("상세 정보")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("LabelsSecondary"))
                        Spacer()
                    }
                    .padding(.leading)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("주소")
                                .font(.subheadline)
                                .foregroundColor(Color("LabelsSecondary"))
                            Text(item.address ?? "No Address")
                                .font(.body)
                            
                            if let phoneNumber = item.phoneNumber {
                                Divider()
                                    .padding(.vertical, 5)  // 상하간격 추가
                                VStack(alignment: .leading) {
                                    Text("전화번호")
                                        .font(.subheadline)
                                        .foregroundColor(Color("LabelsSecondary"))
                                    Button {
                                        print("tapped")
                                    } label: {
                                        Text(phoneNumber)
                                            .font(.body)
                                            .fontWeight(.medium)
                                    }
                                }
                            }
                        }
                        .padding(.vertical)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .background(colorScheme == .dark ? Color("BGSecondaryDarkElevated") : Color("BGPrimary"))
                    .cornerRadius(8)
                }
                .padding(.horizontal, 20)
                .padding(.top)

                
                // nav link course
                HStack {
                    HStack {
                        Image(systemName: "arrow.uturn.left.circle.fill")
                            .font(.title)
                            .foregroundStyle(.blue)
                            
                        Text("이전 장소")
                            .font(.body)
                            .foregroundStyle(.blue)
                    }
                    Spacer()
                    HStack {
                        Text("다음 장소")
                            .font(.body)
                            .foregroundStyle(Color("LabelsTertiary"))

                        Image(systemName: "arrow.uturn.right.circle.fill")
                            .font(.title)
                            .foregroundStyle(Color("LabelsTertiary"))
                    }
                }
                .padding(.top)
                .padding(.horizontal, 20)
        
                // TextField
                if isFirstCourse {
                    VStack(alignment: .leading) {
                        TextField("여기에 텍스트를 입력하세요.", text: $firstCourseText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        
                        Text("오늘 하루는 어떤 날인가요?")
                            .font(.footnote)
                            .foregroundColor(Color("LabelsSecondary"))
                    }
                    .padding(.horizontal, 20)
                    .padding(.top)
                }
                
                Button {
                    
                } label: {
                    Text("코스에 추가하기")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .padding(.top)
                }
                Spacer()
            }
            .background(colorScheme == .dark ? Color("BGPrimaryDarkElevated") : Color("BGSecondary"))
        }
    }
}

#Preview {
    NavigationStack {
        SearchResultDetailView(item: MapDetailItem.recentVisitedExample.first!, isFirstCourse: .constant(true))
    }
}

