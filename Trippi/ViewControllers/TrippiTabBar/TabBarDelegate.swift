//
//  TabBarDelegate.swift
//  Trippi
//
//  Created by macmini50 on 17/08/23.
//

import UIKit

protocol TabBarDelegate: AnyObject {
    func presentShareVC()
    func presentCommentsVC()
    func hideAddButton()
    func unHideAddButton()
    
    func pushTripVC()
}
