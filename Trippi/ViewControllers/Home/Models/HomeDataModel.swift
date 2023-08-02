//
//  HomeDataModel.swift
//  Trippi
//
//  Created by macmini50 on 02/08/23.
//

import Foundation

enum HomeDataType {
    case city
    case topJourney
    case moment
}

struct HomeDataModel {
    var type: HomeDataType
    var data: Any
}
