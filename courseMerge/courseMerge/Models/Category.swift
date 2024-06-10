//
//  Category.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/10/24.
//

import Foundation
import SwiftUI

struct Category {
    let symbol: String?
    let customImage: Image?
    let context: String
}

extension Category {
    static var categoryItems: [Category] = [
        Category(symbol: nil, customImage: Image("custom.cup.and.saucer.circle.fill"), context: "카페"),
        Category(symbol: "fork.knife.circle.fill", customImage: nil, context: "식당"),
        Category(symbol: "storefront.circle.fill", customImage: nil, context: "편의점"),
        Category(symbol: "parkingsign.circle.fill", customImage: nil, context: "주차장"),
        Category(symbol: "cart.circle.fill", customImage: nil, context: "마트"),
    ]
}
