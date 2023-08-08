//
//  ShareUserModel.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 07/08/23.
//

import Foundation

struct ShareUserModel {
    var id = UUID().uuidString
    var username: String
    var pic: String
    var isSelected: Bool
}
