//
//  MapItemRow.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/12/24.
//

import SwiftUI

struct MapItemRow: View {
    let item: MapDetailItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name ?? "No Name")
                    .font(.body)
                Text(item.address ?? "No address")
                    .font(.subheadline)
                    .foregroundStyle(Color("LabelsSecondary"))
            }
            
            Spacer()
            
            Text(item.category?.rawValue ?? "No Category")
                .foregroundStyle(Color("LabelsSecondary"))
        }
    }
}

#Preview {
    MapItemRow(item: MapDetailItem.recentVisitedExample.first!)
}
