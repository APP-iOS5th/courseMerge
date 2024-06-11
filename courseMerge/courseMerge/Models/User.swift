//
//  User.swift
//  CourseMerge
//
//  Created by Yungui Lee on 6/11/24.
//

import Foundation
import FirebaseAuth

struct User: Identifiable {
    let id: UUID = UUID()
    var uid: String? // Firebase UID
    var username: String
    var usercolor: String
    var isHost: Bool
}

extension User {
    static let  ProfileColor: [String] = ["PastelBlue", "PastelYellow", "PastelGreen"]
    
    static let hexColors = [
        "#FF6347", // Tomato
        "#FFD700", // Gold
        "#20B2AA", // LightSeaGreen
        "#9400D3", // DarkViolet
        "#00FFFF", // Cyan
        "#ADFF2F", // GreenYellow
        "#4682B4", // SteelBlue
        "#FF69B4", // HotPink
        "#CD5C5C", // IndianRed
        "#808000", // Olive
        "#4169E1", // RoyalBlue
        "#FFA07A", // LightSalmon
        "#00FF7F", // SpringGreen
        "#8A2BE2", // BlueViolet
        "#F08080", // LightCoral
        "#32CD32", // LimeGreen
        "#20B2AA", // LightSeaGreen (중복 추가)
        "#8B008B", // DarkMagenta
        "#00FF00", // Lime
        "#FF4500", // OrangeRed
        "#1E90FF", // DodgerBlue
        "#FF1493"  // DeepPink
    ]
    
    // MARK: - 랜덤 컬러 생성
    
    static func randomColor() -> String {
        let combinedColors = ProfileColor + hexColors
        let uniqueColors = Array(Set(combinedColors))
        if let randomColor = uniqueColors.randomElement() {
            if ProfileColor.contains(randomColor) {
                    return randomColor
            } else {
                    return randomColor
            }
        } else {
         return "Gray" // 기본값은 회색
        }
    }
    
    // MARK: - 랜덤 닉네임 생성

    static func generateRandomUsername(excludeUsernames: [String]) -> String {
        let determiners = [
            "예쁜", "화난", "귀여운", "배고픈", "철학적인",
            "현학적인", "슬픈", "푸른", "비싼", "밝은",
            "별빛", "달빛", "햇빛", "눈부신", "신비한",
            "기운찬", "힘찬", "맑은", "고요한", "찬란한"
        ]
        
        let animals = [
            "호랑이", "비버", "강아지", "부엉이", "여우",
            "치타", "문어", "고양이", "미어캣", "다람쥐",
            "도깨비", "펭귄", "사자", "늑대", "용",
            "독수리", "백조", "사슴", "부엉이", "물개"
        ]
        
        let maxAttempts = 100
        var attempts = 0
        var uniqueUsername: String
        
        repeat {
            attempts += 1
            let randomDeterminer = determiners.randomElement() ?? "사용자"
            let randomAnimal = animals.randomElement() ?? "사용자"
            uniqueUsername = "\(randomDeterminer)\(randomAnimal)\(Int.random(in: 1000...9999))"
        } while excludeUsernames.contains(uniqueUsername) && attempts < maxAttempts
        
        if attempts == maxAttempts {
            uniqueUsername = "기본사용자\(Int.random(in: 1000...9999))"
        }
        
        return uniqueUsername
    }
}

