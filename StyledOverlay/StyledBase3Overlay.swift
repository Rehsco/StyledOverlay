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
public class StyledBase3Overlay: StyledBaseOverlay {
    private var _upperView = UIView()
    private var _centerView = UIView()
    private var _lowerView = UIView()
    
    public var upperView: UIView {
        get {
            return _upperView
        }
    }
    public var centerView: UIView {
        get {
            return _centerView
        }
    }
    public var lowerView: UIView {
        get {
            return _lowerView
        }
    }

    @IBInspectable
    public var upperViewWeight: CGFloat = 1 {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable
    public var centerViewWeight: CGFloat = 1 {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable
    public var lowerViewWeight: CGFloat = 1 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// The content view insets, also known as border margins.
    @IBInspectable public var contentViewMargins: UIEdgeInsets? {
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
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutViews()
    }
    
    public func layoutViews() {
        let viewRect = self.marginsForRect(bounds, margins: self.contentViewMargins ?? UIEdgeInsetsZero)
        let totalViewWeight = self.upperViewWeight + self.centerViewWeight + self.lowerViewWeight
        
        let uvWeight = self.upperViewWeight / totalViewWeight
        let cvWeight = self.centerViewWeight / totalViewWeight
        let lvWeight = self.lowerViewWeight / totalViewWeight
        
        let cvYOffset = viewRect.origin.y + viewRect.size.height * uvWeight
        let lvYOffset = cvYOffset + viewRect.size.height * cvWeight
        
        _upperView.frame = CGRectMake(viewRect.origin.x, viewRect.origin.y, viewRect.size.width, viewRect.size.height * uvWeight)
        _centerView.frame = CGRectMake(viewRect.origin.x, cvYOffset, viewRect.size.width, viewRect.size.height * cvWeight)
        _lowerView.frame = CGRectMake(viewRect.origin.x, lvYOffset, viewRect.size.width, viewRect.size.height * lvWeight)
    }
}
