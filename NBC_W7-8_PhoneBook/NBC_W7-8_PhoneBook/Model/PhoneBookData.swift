//
//  PhoneBookData.swift
//  NBC_W7-8_PhoneBook
//
//  Created by 황석현 on 12/9/24.
//

import UIKit

/// 연락처 정보
struct PhoneBookData {
    let id = UUID()
    let image: UIImage?
    let name: String
    let phoneNumber: String
}
