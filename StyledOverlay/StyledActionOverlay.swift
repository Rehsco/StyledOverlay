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
    case play
    case download
    case encrypted
    case busyLoop
    case progressRing(progress: Float)
}

@IBDesignable
open class StyledActionOverlay: StyledBase3Overlay {
    open var upperLabel = StyledLabel()
    open var actionLayer = CALayer()
    open var actionBGShape: CALayer?
    open var actionShape = CALayer()
    open var lowerLabel = StyledLabel()
    
    open var actionImageSize: CGSize = CGSize(width: 36.0, height: 36.0) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    open var actionType: StyledActionType = .play {
        didSet {
            self.initActionLayer()
        }
    }
    
    @IBInspectable
    open var contentTintColor: UIColor = .white {
        didSet {
            self.initActionLayer()
        }
    }

    @IBInspectable
    open var contentBackgroundTintColor: UIColor = UIColor.init(white: 0.3, alpha: 1.0) {
        didSet {
            self.initActionLayer()
        }
    }
    
    open var indicatorLineWidth: CGFloat = 1.5 {
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
        self.centerView.layer.insertSublayer(self.actionLayer, at: 0)
        self.lowerView.addSubview(self.lowerLabel)
        
        self.upperLabel.textAlignment = .center
        self.lowerLabel.textAlignment = .center
    }
    
    func initActionLayer() {
        self.actionLayer.sublayers?.removeAll()
        let shapeName: String?
        switch self.actionType {
        case .play:
            shapeName = "SOPlayImage_36pt"
        case .download:
            shapeName = "SODownloadImage_36pt"
        case .encrypted:
            shapeName = "SOEncryptedImage_36pt"
        case .busyLoop:
            shapeName = nil
            let gradProgShape = WCGraintCircleLayer(bounds: CGRect(origin: CGPoint.zero, size: self.actionImageSize), position: CGPoint.zero, fromColor: self.contentTintColor.withAlphaComponent(0.0), toColor: self.contentTintColor.withAlphaComponent(1.0), linewidth: self.indicatorLineWidth, toValue: 0.99)
            self.actionShape = gradProgShape
            gradProgShape.animateCircleRotation(duration: 1.0)
            self.actionLayer.addSublayer(self.actionShape)
        case .progressRing(let progress):
            shapeName = nil
            let gradProgShape = WCGraintCircleLayer(bounds: CGRect(origin: CGPoint.zero, size: self.actionImageSize), position: CGPoint.zero, fromColor: self.contentTintColor.withAlphaComponent(0.95), toColor: self.contentTintColor.withAlphaComponent(1.0), linewidth: self.indicatorLineWidth, toValue: CGFloat(progress))
            let bgShape = WCGraintCircleLayer(bounds: CGRect(origin: CGPoint.zero, size: self.actionImageSize), position: CGPoint.zero, fromColor: self.contentBackgroundTintColor, toColor: self.contentBackgroundTintColor, linewidth: self.indicatorLineWidth, toValue: 0.99)
            self.actionBGShape = bgShape
            self.actionShape = gradProgShape
            self.actionLayer.addSublayer(bgShape)
            self.actionLayer.addSublayer(self.actionShape)
        }
        if let shapeName = shapeName {
            if let image = UIImage(named:shapeName, in:Bundle(for:StyledActionOverlay.classForCoder()), compatibleWith:nil)?.tint(self.contentTintColor) {
                self.actionShape = ImageShapeLayerFactory.createImageShape(CGRect(origin: CGPoint.zero, size: image.size), image: image, imageStyle: .box)
                self.actionLayer.addSublayer(self.actionShape)
            }
        }
        self.actionBGShape?.isHidden = true
        self.actionShape.isHidden = true
    }
    
    open override func layoutViews() {
        super.layoutViews()
        self.upperLabel.frame = self.upperView.bounds
        self.actionLayer.frame = self.centerView.bounds
        self.lowerLabel.frame = self.lowerView.bounds
        let ox = (self.actionLayer.bounds.size.width - actionImageSize.width) * 0.5
        let oy = (self.actionLayer.bounds.size.height - actionImageSize.height) * 0.5
        self.actionShape.frame = CGRect(x: ox, y: oy, width: actionImageSize.width, height: actionImageSize.height)
        self.actionBGShape?.frame = CGRect(x: ox, y: oy, width: actionImageSize.width, height: actionImageSize.height)
        self.actionBGShape?.isHidden = false
        self.actionShape.isHidden = false
    }
}
