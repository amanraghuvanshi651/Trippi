//
//  UIViewController+Extension.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 21/07/23.
//

import UIKit

extension UIViewController {
    func pushVC( vc:UIViewController, isAnimated:Bool = true){
        self.navigationController?.pushViewController(vc, animated: isAnimated)
    }
    
    func presentVC( vc:UIViewController, isAnimated:Bool = true){
        self.present(vc, animated: isAnimated, completion: nil)
    }
    
    func dismissOrPop() {
        if let navigationController = self.navigationController{
            navigationController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
