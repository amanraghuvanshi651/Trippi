//
//  TopTripModel.swift
//  Trippi
//
//  Created by macmini50 on 02/08/23.
//

import Foundation

struct TopTripModel {
    var id = UUID().uuidString
    var image: String
    var title: String
    var description: String
    var isLiked: Bool
    var isSaved: Bool
}

struct Comment {
    var id = UUID().uuidString
}
