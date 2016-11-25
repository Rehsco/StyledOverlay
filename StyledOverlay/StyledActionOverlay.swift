//
//  StyledActionOverlay.swift
//  StyledOverlay
//
//  Created by Martin Rehder on 22.10.2016.
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

import UIKit
import StyledLabel

public enum StyledActionType {
    case Play
    case Download
    case Encrypted
    case BusyLoop
    case ProgressRing(progress: Float)
}

@IBDesignable
public class StyledActionOverlay: StyledBase3Overlay {
    public var upperLabel = StyledLabel()
    public var actionLayer = CALayer()
    public var actionShape = CALayer()
    public var actionBGShape: CALayer?
    public var lowerLabel = StyledLabel()
    
    public var actionImageSize: CGSize = CGSizeMake(36.0, 36.0) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    public var actionType: StyledActionType = .Play {
        didSet {
            self.initActionLayer()
        }
    }
    
    @IBInspectable
    public var contentTintColor: UIColor = .whiteColor() {
        didSet {
            self.initActionLayer()
        }
    }
    
    @IBInspectable
    public var contentBackgroundTintColor: UIColor = UIColor.init(white: 0.3, alpha: 1.0) {
        didSet {
            self.initActionLayer()
        }
    }
    
    public var indicatorLineWidth: CGFloat = 1.5 {
        didSet {
            self.initActionLayer()
        }
    }

    override func initView() {
        super.initView()
        self.initLabels()
    }
    
    func initLabels() {
        self.upperView.addSubview(self.upperLabel)
        self.centerView.layer.insertSublayer(self.actionLayer, atIndex: 0)
        self.lowerView.addSubview(self.lowerLabel)
        
        self.upperLabel.textAlignment = .Center
        self.lowerLabel.textAlignment = .Center
    }
    
    func initActionLayer() {
        self.actionLayer.sublayers?.removeAll()
        let shapeName: String?
        switch self.actionType {
        case .Play:
            shapeName = "SOPlayImage_36pt"
        case .Download:
            shapeName = "SODownloadImage_36pt"
        case .Encrypted:
            shapeName = "SOEncryptedImage_36pt"
        case .BusyLoop:
            shapeName = nil
            let gradProgShape = WCGraintCircleLayer(bounds: CGRect(origin: CGPoint.zero, size: self.actionImageSize), position: CGPoint.zero, fromColor: self.contentTintColor.colorWithAlphaComponent(0.0), toColor: self.contentTintColor.colorWithAlphaComponent(1.0), linewidth: self.indicatorLineWidth, toValue: 0.99)
            self.actionShape = gradProgShape
            gradProgShape.animateCircleRotation(1.0)
            self.actionLayer.addSublayer(self.actionShape)
        case .ProgressRing(let progress):
            shapeName = nil
            let gradProgShape = WCGraintCircleLayer(bounds: CGRect(origin: CGPoint.zero, size: self.actionImageSize), position: CGPoint.zero, fromColor: self.contentTintColor.colorWithAlphaComponent(0.95), toColor: self.contentTintColor.colorWithAlphaComponent(1.0), linewidth: self.indicatorLineWidth, toValue: CGFloat(progress))
            let bgShape = WCGraintCircleLayer(bounds: CGRect(origin: CGPoint.zero, size: self.actionImageSize), position: CGPoint.zero, fromColor: self.contentBackgroundTintColor, toColor: self.contentBackgroundTintColor, linewidth: self.indicatorLineWidth, toValue: 0.99)
            self.actionBGShape = bgShape
            self.actionShape = gradProgShape
            self.actionLayer.addSublayer(bgShape)
            self.actionLayer.addSublayer(self.actionShape)
        }
        if let shapeName = shapeName {
            if let image = UIImage(named:shapeName, inBundle:NSBundle(forClass:StyledActionOverlay.classForCoder()), compatibleWithTraitCollection:nil)?.tint(self.contentTintColor) {
                self.actionShape = ImageShapeLayerFactory.createImageShape(CGRect(origin: CGPoint.zero, size: image.size), image: image, imageStyle: .Box)
                self.actionLayer.addSublayer(self.actionShape)
            }
        }
        self.actionBGShape?.hidden = true
        self.actionShape.hidden = true
        self.updateActionPosition()
        self.setNeedsLayout()
    }
    
    public override func layoutViews() {
        super.layoutViews()
        self.updateActionPosition()
        self.actionShape.hidden = false
        self.actionBGShape?.hidden = false
    }
    
    func updateActionPosition() {
        self.upperLabel.frame = self.upperView.bounds
        self.actionLayer.frame = self.centerView.bounds
        self.lowerLabel.frame = self.lowerView.bounds
        let ox = (self.actionLayer.bounds.size.width - actionImageSize.width) * 0.5
        let oy = (self.actionLayer.bounds.size.height - actionImageSize.height) * 0.5
        self.actionShape.frame = CGRectMake(ox, oy, actionImageSize.width, actionImageSize.height)
        self.actionBGShape?.frame = CGRectMake(ox, oy, actionImageSize.width, actionImageSize.height)
    }
}
