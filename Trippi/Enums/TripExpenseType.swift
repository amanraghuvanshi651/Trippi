//
//  TripExpenseType.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 22/08/23.
//

import Foundation

enum TripExpenseType: String, CaseIterable {
    case fuel = "Fuel"
    case transport = "Transport"
    case food = "Food"
    case activity = "Activity"
    case ticket = "Ticket"
    case hotel = "Hotel"
    case custom = "Custom"
}
