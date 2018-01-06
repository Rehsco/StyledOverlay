//
//  StyledOverlayAnimator.swift
//  StyledOverlay
//
//  Created by Martin Rehder on 05.01.2018.
//  Copyright © 2018 Martin Jacob Rehder. All rights reserved.
//

import UIKit

public enum StyledOverlayAnimationStyle {
    case noAnimation, topToBottom, bottomToTop, leftToRight, rightToLeft, fadeInOut
}

public enum StyledOverlayAnimationDirection {
    case ingoing, outgoing
}

open class StyledOverlayAnimator {

    public static func showAnimation(forView baseView: UIView, direction: StyledOverlayAnimationDirection = .ingoing, animationStyle: StyledOverlayAnimationStyle = .bottomToTop, boundingAnimationOffset: CGFloat = 15.0, animationDuration: TimeInterval = 0.2, completionHandler: (()->Void)? = nil) {
        
        let rv = UIApplication.shared.keyWindow! as UIWindow
        let animationStartOrigin = self.calculateAnimationOrigin(baseView: baseView, direction: direction, animationStyle: animationStyle)
        let animationEndOrigin = self.calculateAnimationOrigin(baseView: baseView, direction: direction == .ingoing ? .outgoing : .ingoing, animationStyle: animationStyle)

        let endCenter = CGPoint(x: animationEndOrigin.x + baseView.bounds.width * 0.5, y: animationEndOrigin.y + baseView.bounds.height * 0.5)
        var animationCenter = direction == .ingoing ? rv.center : endCenter
        
        switch animationStyle {
        case .noAnimation:
            return
        case .topToBottom:
            animationCenter = CGPoint(x: animationCenter.x, y: animationCenter.y + boundingAnimationOffset)
        case .bottomToTop:
            animationCenter = CGPoint(x: animationCenter.x, y: animationCenter.y - boundingAnimationOffset)
        case .leftToRight:
            animationCenter = CGPoint(x: animationCenter.x + boundingAnimationOffset, y: animationCenter.y)
        case .rightToLeft:
            animationCenter = CGPoint(x: animationCenter.x - boundingAnimationOffset, y: animationCenter.y)
        case .fadeInOut:
            let currentAlpha: CGFloat = direction == .ingoing ? 0.0 : 1.0
            baseView.alpha = currentAlpha
            UIView.animate(withDuration: animationDuration, animations: {
                baseView.alpha = 1.0 - currentAlpha
            }, completion: { finished in
                completionHandler?()
            })
            return
        }
        
        baseView.frame.origin = animationStartOrigin

        UIView.animate(withDuration: animationDuration, animations: {
            baseView.center = animationCenter
        }, completion: { finished in
            UIView.animate(withDuration: animationDuration, animations: {
                baseView.center = rv.center
                completionHandler?()
            })
        })
    }
    
    private static func calculateAnimationOrigin(baseView: UIView, direction: StyledOverlayAnimationDirection, animationStyle: StyledOverlayAnimationStyle) -> CGPoint {
        let rv = UIApplication.shared.keyWindow! as UIWindow
        let hw = baseView.bounds.width * 0.5
        let hh = baseView.bounds.height * 0.5
        if direction == .outgoing {
            return CGPoint(x: rv.center.x - hw, y: rv.center.y - hh)
        }
        else {
            switch animationStyle {
            case .noAnimation, .fadeInOut:
                return rv.center
            case .topToBottom:
                return CGPoint(x: rv.center.x - hw, y: rv.center.y - (rv.bounds.height + baseView.bounds.height))
            case .bottomToTop:
                return CGPoint(x: rv.center.x - hw, y: rv.center.y + rv.bounds.height)
            case .leftToRight:
                return CGPoint(x: rv.center.x  - (rv.bounds.width + baseView.bounds.width), y: rv.center.y - hh)
            case .rightToLeft:
                return CGPoint(x: rv.center.x  + rv.bounds.width, y: rv.center.y - hh)
            }
        }
    }
}
