//
//  WCGradientCircleLayer.swift
//  StyledOverlay
//
//  Created by Martin Rehder on 24.11.2016.
/*
 * Copyright 2016-present Martin Jacob Rehder.
 * http://www.rehsco.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

// Based on http://stackoverflow.com/a/36655516/4180386

import UIKit

class WCGraintCircleLayer: CALayer {
    
    override init () {
        super.init()
    }
    
    convenience init(bounds:CGRect,position:CGPoint,fromColor:UIColor,toColor:UIColor,linewidth:CGFloat,toValue:CGFloat) {
        self.init()
        self.bounds = bounds
        self.position = position
        let colors : [UIColor] = self.graintFromColor(fromColor, toColor:toColor, count:4)
        for i in 0..<colors.count-1 {
            let graint = CAGradientLayer()
            graint.bounds = CGRectMake(0,0,CGRectGetWidth(bounds)/2,CGRectGetHeight(bounds)/2)
            let valuePoint = self.positionArrayWithMainBounds(self.bounds)[i]
            graint.position = valuePoint
            let fromColor = colors[i]
            let toColor = colors[i+1]
            let colors : [CGColorRef] = [fromColor.CGColor,toColor.CGColor]
            let stopOne: CGFloat = 0.0
            let stopTwo: CGFloat = 1.0
            let locations : [CGFloat] = [stopOne,stopTwo]
            graint.colors = colors
            graint.locations = locations
            graint.startPoint = self.startPoints()[i]
            graint.endPoint = self.endPoints()[i]
            self.addSublayer(graint)
            //Set mask
            let shapelayer = CAShapeLayer()
            let rect = CGRectMake(0,0,CGRectGetWidth(self.bounds) - 2 * linewidth, CGRectGetHeight(self.bounds) - 2 * linewidth)
            shapelayer.bounds = rect
            shapelayer.position = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2)
            shapelayer.strokeColor = UIColor.blueColor().CGColor
            shapelayer.fillColor = UIColor.clearColor().CGColor
            shapelayer.path = UIBezierPath(roundedRect: rect, cornerRadius: CGRectGetWidth(rect)/2).CGPath
            shapelayer.lineWidth = linewidth
            shapelayer.lineCap = kCALineCapRound
            shapelayer.strokeStart = 0.010
            let finalValue = (toValue*0.99)
            shapelayer.strokeEnd = finalValue//0.99;
            self.mask = shapelayer
        }
    }
    
    override init(layer: AnyObject) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layerWithWithBounds(bounds:CGRect, position:CGPoint, fromColor:UIColor, toColor:UIColor, linewidth : CGFloat,toValue:CGFloat) -> WCGraintCircleLayer {
        let layer = WCGraintCircleLayer(bounds: bounds,position: position,fromColor:fromColor, toColor: toColor,linewidth: linewidth,toValue:toValue )
        return layer
    }
    
    func graintFromColor(fromColor:UIColor, toColor:UIColor, count:Int) -> [UIColor]{
        var fromR:CGFloat = 0.0,fromG:CGFloat = 0.0,fromB:CGFloat = 0.0,fromAlpha:CGFloat = 0.0
        fromColor.getRed(&fromR,green: &fromG,blue: &fromB,alpha: &fromAlpha)
        
        var toR:CGFloat = 0.0,toG:CGFloat = 0.0,toB:CGFloat = 0.0,toAlpha:CGFloat = 0.0
        toColor.getRed(&toR,green: &toG,blue: &toB,alpha: &toAlpha)
        
        var result : [UIColor]! = [UIColor]()
        
        for i in 0...count {
            let oneR:CGFloat = fromR + (toR - fromR)/CGFloat(count) * CGFloat(i)
            let oneG : CGFloat = fromG + (toG - fromG)/CGFloat(count) * CGFloat(i)
            let oneB : CGFloat = fromB + (toB - fromB)/CGFloat(count) * CGFloat(i)
            let oneAlpha : CGFloat = fromAlpha + (toAlpha - fromAlpha)/CGFloat(count) * CGFloat(i)
            let oneColor = UIColor.init(red: oneR, green: oneG, blue: oneB, alpha: oneAlpha)
            result.append(oneColor)
        }
        return result
    }
    
    func positionArrayWithMainBounds(bounds:CGRect) -> [CGPoint]{
        let first = CGPointMake((CGRectGetWidth(bounds)/4)*3, (CGRectGetHeight(bounds)/4)*1)
        let second = CGPointMake((CGRectGetWidth(bounds)/4)*3, (CGRectGetHeight(bounds)/4)*3)
        let third = CGPointMake((CGRectGetWidth(bounds)/4)*1, (CGRectGetHeight(bounds)/4)*3)
        let fourth = CGPointMake((CGRectGetWidth(bounds)/4)*1, (CGRectGetHeight(bounds)/4)*1)
        return [first,second,third,fourth]
    }
    
    func startPoints() -> [CGPoint] {
        return [CGPointMake(0,0),CGPointMake(1,0),CGPointMake(1,1),CGPointMake(0,1)]
    }
    
    func endPoints() -> [CGPoint] {
        return [CGPointMake(1,1),CGPointMake(0,1),CGPointMake(0,0),CGPointMake(1,0)]
    }
    
    func midColorWithFromColor(fromColor:UIColor, toColor:UIColor, progress:CGFloat) -> UIColor {
        var fromR:CGFloat = 0.0,fromG:CGFloat = 0.0,fromB:CGFloat = 0.0,fromAlpha:CGFloat = 0.0
        fromColor.getRed(&fromR,green: &fromG,blue: &fromB,alpha: &fromAlpha)
        
        var toR:CGFloat = 0.0,toG:CGFloat = 0.0,toB:CGFloat = 0.0,toAlpha:CGFloat = 0.0
        toColor.getRed(&toR,green: &toG,blue: &toB,alpha: &toAlpha)
        
        let oneR = fromR + (toR - fromR) * progress
        let oneG = fromG + (toG - fromG) * progress
        let oneB = fromB + (toB - fromB) * progress
        let oneAlpha = fromAlpha + (toAlpha - fromAlpha) * progress
        let oneColor = UIColor.init(red: oneR, green: oneG, blue: oneB, alpha: oneAlpha)
        return oneColor
    }
    
    // This is what you call if you want to draw a full circle.
    func animateCircle(duration: NSTimeInterval) {
        animateCircleTo(duration, fromValue: 0.010, toValue: 0.99)
    }
    
    // This is what you call to draw a partial circle.
    func animateCircleTo(duration: NSTimeInterval, fromValue: CGFloat, toValue: CGFloat){
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.removedOnCompletion = true
        // Set the animation duration appropriately
        animation.duration = duration
        
        // Animate from 0.010 (no circle) to 0.99 (full circle)
        animation.fromValue = 0.010
        animation.toValue = toValue
        
        // Do an easeout. Don't know how to do a spring instead
        //animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        // Set the circleLayer's strokeEnd property to 0.99 now so that it's the
        // right value when the animation ends.
        let circleMask = self.mask as! CAShapeLayer
        circleMask.strokeEnd = toValue
        
        // Do the actual animation
        circleMask.removeAllAnimations()
        circleMask.addAnimation(animation, forKey: "animateCircle")
    }
    
    func animateCircleRotation(duration: NSTimeInterval) {
        let circleMask = self
        if let rotationAtStart = circleMask.valueForKeyPath("transform.rotation") as? NSNumber {
            let myRotationTransform = CATransform3DRotate(circleMask.transform, CGFloat(M_PI * 2.0), 0.0, 0.0, 1.0)
            circleMask.transform = myRotationTransform
            let myAnimation = CABasicAnimation(keyPath: "transform.rotation")
            myAnimation.duration = duration
            myAnimation.repeatCount = .infinity
            myAnimation.fromValue = rotationAtStart
            myAnimation.toValue = NSNumber(float: rotationAtStart.floatValue + Float(M_PI * 2.0))
            circleMask.addAnimation(myAnimation, forKey: "transform.rotation")
        }
    }
}
