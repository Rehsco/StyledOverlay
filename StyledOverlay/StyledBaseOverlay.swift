//
//  StyledBaseOverlay.swift
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

open class StyledBaseOverlay: UIView {
    var styleLayer = CAShapeLayer()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initView()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutComponents()
    }
    
    func initView() {
        self.backgroundColor = .clear
        if self.styleLayer.superlayer == nil {
            self.layer.insertSublayer(self.styleLayer, at: 0)
        }
    }

    // MARK: - Control Style
    
    /// The view's style.
    open var style: ShapeStyle? {
        didSet {
            self.setNeedsLayout()
        }
    }
    /// Convenience for getting a valid style
    open func getStyle() -> ShapeStyle {
        return self.style ?? overlayStyleAppearance.style
    }
    
    /// The view’s background color.
    @IBInspectable open var styleColor: UIColor? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// The view's border color.
    @IBInspectable open var borderColor: UIColor? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// The view's border width.
    open var borderWidth: CGFloat? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// The view’s background color.
    override open var backgroundColor: UIColor? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// The controls background insets. These are margins for the inner background.
    open var backgroundInsets: UIEdgeInsets? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    // MARK: - Internal View
    
    func marginsForRect(_ rect: CGRect, margins: UIEdgeInsets) -> CGRect {
        return CGRect(x: rect.origin.x + margins.left, y: rect.origin.y + margins.top, width: rect.size.width - (margins.left + margins.right), height: rect.size.height - (margins.top + margins.bottom))
    }
    
    func layoutComponents() {
        self.applyStyle(self.getStyle())
    }
    
    func createBorderLayer(_ style: ShapeStyle, layerRect: CGRect) -> CALayer? {
        let borderWidth = self.borderWidth ?? overlayStyleAppearance.borderWidth
        if borderWidth > 0 {
            let bLayer = StyledShapeLayer.createShape(style, bounds: layerRect, color: .clear, borderColor: borderColor ?? overlayStyleAppearance.borderColor, borderWidth: borderWidth)
            return bLayer
        }
        return nil
    }
    
    func applyStyle(_ style: ShapeStyle) {
        if self.styleLayer.superlayer == nil {
            self.layer.addSublayer(styleLayer)
        }
        
        let layerRect = self.marginsForRect(bounds, margins: backgroundInsets ?? overlayStyleAppearance.backgroundInsets)
        let bgColor: UIColor = self.styleColor ?? backgroundColor ?? overlayStyleAppearance.backgroundColor
        let bgsLayer = StyledShapeLayer.createShape(style, bounds: layerRect, color: bgColor)
        
        // Add layer with border, if required
        if let bLayer = self.createBorderLayer(style, layerRect: layerRect) {
            bgsLayer.addSublayer(bLayer)
        }
        
        if styleLayer.superlayer != nil {
            layer.replaceSublayer(styleLayer, with: bgsLayer)
        }
        styleLayer = bgsLayer
        styleLayer.frame = layerRect
    }
}
