//
//  Animator.swift
//  Trippi
//
//  Created by macmini50 on 25/07/23.
//

import UIKit

enum PresentationType {
    case present
    case dismiss
    
    var isPresenting: Bool {
        return self == .present
    }
}

final class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    static let duration: TimeInterval = 0.5
    
    private let type: PresentationType
    private let firstViewController: HomeViewController
    private let secondViewController: SettingViewController
    private let selectedCellImageViewSnapshot: UIView
    private let cellImageViewRect: CGRect
    
    private var isSettingVC = false
    
    init?(type: PresentationType, firstViewController: HomeViewController, secondViewController: SettingViewController, selectedCellImageViewSnapshot: UIView) {
        self.type = type
        self.firstViewController = firstViewController
        self.secondViewController = secondViewController
        self.selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
        
        guard let window = firstViewController.view.window ?? secondViewController.view.window,
              let selectedCell = firstViewController.profileButtonContainerView
        else { return nil }
        
        self.cellImageViewRect = selectedCell.convert(selectedCell.bounds, to: window)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if type == .present {
            isSettingVC = true
        } else {
            isSettingVC = false
        }
        
        let view = secondViewController.view ?? firstViewController.view ?? nil
        
        guard let toView = view
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        containerView.addSubview(toView)
        
        // deleted line: transitionContext.completeTransition(true)
        guard let window = firstViewController.view.window ?? secondViewController.view.window,
              let cellImageSnapshot = firstViewController.profileButtonContainerView.snapshotView(afterScreenUpdates: false),
              let controllerImageSnapshot = secondViewController.profileButton.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        let isPresenting = type.isPresenting
        
        let imageViewSnapshot: UIView
        
        if isPresenting {
            imageViewSnapshot = cellImageSnapshot
        } else {
            imageViewSnapshot = controllerImageSnapshot
        }
        
        toView.alpha = 0
        
        [imageViewSnapshot].forEach { containerView.addSubview($0) }
        
        let controllerImageViewRect = secondViewController.profileButton.convert(secondViewController.profileButton.bounds, to: window)
        
        [imageViewSnapshot].forEach {
            $0.frame = isPresenting ? cellImageViewRect : controllerImageViewRect
        }
        
        if isPresenting {
            secondViewController.badgeView.alpha = 0
            secondViewController.profileButton.alpha = 0
            firstViewController.profileButtonContainerView.isHidden = true
        }
        
        UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                imageViewSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
                if self.isSettingVC {
                    toView.alpha = 1
                }
            }
        }, completion: { _ in
            
            if isPresenting {
                UIView.animate(withDuration: 0.3) {
                    if self.isSettingVC {
                        self.secondViewController.badgeView.alpha = 1
                        self.secondViewController.profileButton.alpha = 1
                    }
                } completion: { _ in
                    imageViewSnapshot.removeFromSuperview()
                }
            } else {
                toView.alpha = 1
                imageViewSnapshot.removeFromSuperview()
            }
            
            transitionContext.completeTransition(true)
        })
    }
}
