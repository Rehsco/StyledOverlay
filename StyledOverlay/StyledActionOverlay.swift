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
}

@IBDesignable
public class StyledActionOverlay: StyledBase3Overlay {
    public var upperLabel = StyledLabel()
    public var actionLayer = CALayer()
    public var actionShape = CALayer()
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
            self.setNeedsLayout()
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
        let shapeName: String
        switch self.actionType {
        case .Play:
            shapeName = "SOPlayImage_36pt"
        case .Download:
            shapeName = "SODownloadImage_36pt"
        case .Encrypted:
            shapeName = "SOEncryptedImage_36pt"
        }
        if let image = UIImage(named:shapeName, inBundle:NSBundle(forClass:StyledActionOverlay.classForCoder()), compatibleWithTraitCollection:nil)?.tint(self.contentTintColor) {
            self.actionShape = ImageShapeLayerFactory.createImageShape(CGRect(origin: CGPointZero, size: image.size), image: image, imageStyle: .Box)
            self.actionLayer.addSublayer(self.actionShape)
        }
    }
    
    public override func layoutViews() {
        super.layoutViews()
        self.upperLabel.frame = self.upperView.bounds
        self.actionLayer.frame = self.centerView.bounds
        self.lowerLabel.frame = self.lowerView.bounds
        let ox = (self.actionLayer.bounds.size.width - actionImageSize.width) * 0.5
        let oy = (self.actionLayer.bounds.size.height - actionImageSize.height) * 0.5
        self.actionShape.frame = CGRectMake(ox, oy, actionImageSize.width, actionImageSize.height)
    }
}
