//
//  Animator.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 25/07/23.
//

import UIKit

enum PresentationType {
    case present
    case dismiss
    
    var isPresenting: Bool {
        return self == .present
    }
}

protocol AnimatorDelegate: AnyObject {
    func hideFromViewIfNeeded()
    func unHideFromViewIfNeeded()
    func hideToViewIfNeeded()
    func unHideToViewIfNeeded()
}

final class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    static let duration: TimeInterval = 0.3
    
    var imageViewSnapshot = UIView()
    
    private let type: PresentationType
    private let firstViewController: UIViewController
    private let fromView: UIView
    private let secondViewController: UIViewController
    private let toView: UIView
    private let selectedCellImageViewSnapshot: UIView
    private let cellImageViewRect: CGRect
    
    private var isSettingVC = false
    
    weak var delegate: AnimatorDelegate?
    
    init?(type: PresentationType, firstViewController: UIViewController, fromView: UIView, secondViewController: UIViewController, toView: UIView, selectedCellImageViewSnapshot: UIView) {
        self.type = type
        self.firstViewController = firstViewController
        self.fromView = fromView
        self.secondViewController = secondViewController
        self.toView = toView
        self.selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
        
        guard let window = firstViewController.view.window ?? secondViewController.view.window else { return nil }
        let selectedCell = fromView
        
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
        
        guard let toViewControllersView = view
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        containerView.addSubview(toViewControllersView)
        
        // deleted line: transitionContext.completeTransition(true)
        guard let window = firstViewController.view.window ?? secondViewController.view.window,
              let cellImageSnapshot = fromView.snapshotView(afterScreenUpdates: false),
              let controllerImageSnapshot = toView.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        let isPresenting = type.isPresenting
                
        if isPresenting {
            imageViewSnapshot = cellImageSnapshot
        } else {
            imageViewSnapshot = controllerImageSnapshot
        }
        
        toViewControllersView.alpha = 0
        
        [imageViewSnapshot].forEach { containerView.addSubview($0) }
        
        let controllerImageViewRect = toView.convert(toView.bounds, to: window)
        
        [imageViewSnapshot].forEach {
            $0.frame = isPresenting ? cellImageViewRect : controllerImageViewRect
        }
        
        if isPresenting {
            delegate?.hideToViewIfNeeded()
            delegate?.hideFromViewIfNeeded()
        }
        
        UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.imageViewSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
                if self.isSettingVC {
                    toViewControllersView.alpha = 1
                }
            }
        }, completion: { _ in
            
            if isPresenting {
                if self.isSettingVC {
                    self.delegate?.unHideToViewIfNeeded()
                }
            } else {
                toViewControllersView.alpha = 1
                self.imageViewSnapshot.removeFromSuperview()
            }
            
            transitionContext.completeTransition(true)
        })
    }
}
