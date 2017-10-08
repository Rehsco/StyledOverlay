//
//  StyledBase3Overlay.swift
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

@IBDesignable
open class StyledBase3Overlay: StyledBaseOverlay {
    fileprivate var _upperView = UIView()
    fileprivate var _centerView = UIView()
    fileprivate var _lowerView = UIView()
    
    open var upperView: UIView {
        get {
            return _upperView
        }
    }
    open var centerView: UIView {
        get {
            return _centerView
        }
    }
    open var lowerView: UIView {
        get {
            return _lowerView
        }
    }

    @IBInspectable
    open var upperViewWeight: CGFloat = 1 {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable
    open var centerViewWeight: CGFloat = 1 {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable
    open var lowerViewWeight: CGFloat = 1 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// The content view insets, also known as border margins.
    open var contentViewMargins: UIEdgeInsets? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    // MARK: - View internals
    
    override func initView() {
        super.initView()
        self.addSubview(_upperView)
        self.addSubview(_centerView)
        self.addSubview(_lowerView)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutViews()
    }
    
    open func layoutViews() {
        let viewRect = self.marginsForRect(bounds, margins: self.contentViewMargins ?? UIEdgeInsets.zero)
        let totalViewWeight = self.upperViewWeight + self.centerViewWeight + self.lowerViewWeight
        
        let uvWeight = self.upperViewWeight / totalViewWeight
        let cvWeight = self.centerViewWeight / totalViewWeight
        let lvWeight = self.lowerViewWeight / totalViewWeight
        
        let cvYOffset = viewRect.origin.y + viewRect.size.height * uvWeight
        let lvYOffset = cvYOffset + viewRect.size.height * cvWeight
        
        _upperView.frame = CGRect(x: viewRect.origin.x, y: viewRect.origin.y, width: viewRect.size.width, height: viewRect.size.height * uvWeight)
        _centerView.frame = CGRect(x: viewRect.origin.x, y: cvYOffset, width: viewRect.size.width, height: viewRect.size.height * cvWeight)
        _lowerView.frame = CGRect(x: viewRect.origin.x, y: lvYOffset, width: viewRect.size.width, height: viewRect.size.height * lvWeight)
    }
}
