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
}

@IBDesignable
open class StyledActionOverlay: StyledBase3Overlay {
    open var upperLabel = StyledLabel()
    open var actionLayer = CALayer()
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
            self.setNeedsLayout()
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
        let shapeName: String
        switch self.actionType {
        case .play:
            shapeName = "SOPlayImage_36pt"
        case .download:
            shapeName = "SODownloadImage_36pt"
        case .encrypted:
            shapeName = "SOEncryptedImage_36pt"
        }
        if let image = UIImage(named:shapeName, in:Bundle(for:StyledActionOverlay.classForCoder()), compatibleWith:nil)?.tint(self.contentTintColor) {
            self.actionShape = ImageShapeLayerFactory.createImageShape(CGRect(origin: CGPoint.zero, size: image.size), image: image, imageStyle: .box)
            self.actionLayer.addSublayer(self.actionShape)
        }
    }
    
    open override func layoutViews() {
        super.layoutViews()
        self.upperLabel.frame = self.upperView.bounds
        self.actionLayer.frame = self.centerView.bounds
        self.lowerLabel.frame = self.lowerView.bounds
        let ox = (self.actionLayer.bounds.size.width - actionImageSize.width) * 0.5
        let oy = (self.actionLayer.bounds.size.height - actionImageSize.height) * 0.5
        self.actionShape.frame = CGRect(x: ox, y: oy, width: actionImageSize.width, height: actionImageSize.height)
    }
}
