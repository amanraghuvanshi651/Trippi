//
//  MomentModel.swift
//  Trippi
//
//  Created by macmini50 on 02/08/23.
//

import Foundation

struct MomentModel {
    var id = UUID().uuidString
    var image: String
    var userPic: String
    var username: String
    var description: String
    var isFollowing: Bool
    var isLiked: Bool
    var isSaved: Bool
}
