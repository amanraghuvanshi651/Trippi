//
//  HomeDataModel.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 02/08/23.
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
