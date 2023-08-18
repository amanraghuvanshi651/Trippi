//
//  TripDataModel.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 09/08/23.
//

import Foundation

struct TripDataModel {
    var id: String
    var title: String
    var image: String
    var dates: [TripDate]
    var dayPlan: [TripDayPlan]
    var reservations: [TripReservation]
    var budget: TripBudget
}
