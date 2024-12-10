//
//  Profile.swift
//  NBC_W7-8_PhoneBook
//
//  Created by 황석현 on 12/10/24.
//

import Foundation

// 저장할 데이터의 정보

struct Profile {
    let id: UUID
    let image: String
    let name: String
    let phoneNumber: String
}

struct Poketmon: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprite
}

struct Sprite: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
