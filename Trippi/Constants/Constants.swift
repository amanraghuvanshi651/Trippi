//
//  Constants.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 21/07/23.
//

import UIKit

var FIRST_TIME_USER = "isFirstTimeUser"
var APP_BACKGROUND_COLOR = "AppBackground"
var BUTTON_BACKGROUND_COLOR = "ButtonBackground"
var BUTTON_TEXT_COLOR = "ButtonTextColor"
var HIGHLIGHT_VIEW_BACKGROUND_COLOR = "HighlightViewBackground"
var SECONDARY_TEXT_COLOR = "SecondaryTextColor"
var TEXT_COLOR = "TextColor"
var BADGE_COLOR = "BadgeColor"
var BUTTON_BACKGROUND_TRANSPARENT = "ButtonBackgroundTransparent"


func getVC(storyboard: TrippiStoryboards, vc: String) -> UIViewController {
    let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
    let vc = storyboard.instantiateViewController(identifier: vc)
    return vc
}
