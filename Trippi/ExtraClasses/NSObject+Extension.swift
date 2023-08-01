//
//  NSObject+Extension.swift
//  Trippi
//
//  Created by macmini50 on 01/08/23.
//

import UIKit

extension NSObject {
    static var identifier: String {
        return String(describing: self)
    }
}
