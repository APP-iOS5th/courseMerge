//
//  Category.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/10/24.
//

import Foundation
import SwiftUI

enum Category: String, CaseIterable {
    case cafe = "카페"
    case restaurant = "식당"
    case convenientStore = "편의점"
    case parkArea = "주차장"
    case mart = "마트"
    case park = "공원"
    
    var symbol: String? {
        switch self {
        case .cafe:
            return nil
        case .restaurant:
            return "fork.knife.circle.fill"
        case .convenientStore:
            return "storefront.circle.fill"
        case .parkArea:
            return "parkingsign.circle.fill"
        case .mart:
            return "cart.circle.fill"
        case .park:
            return "tree.circle.fill"
        }
    }
    
    var customImage: Image? {
        switch self {
        case .cafe:
            return Image("custom.cup.and.saucer.circle.fill")
        default:
            return nil
        }
    }
}

struct CategoryItem {
    let category: Category
    var symbol: String? {
        category.symbol
    }
    var customImage: Image? {
        category.customImage
    }
    var context: String {
        category.rawValue
    }
}

extension CategoryItem {
    static var categoryItems: [CategoryItem] = Category.allCases.map { CategoryItem(category: $0) }
}
