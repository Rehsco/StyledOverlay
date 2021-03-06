//
//  OverlayStyleAppearance.swift
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

let overlayStyleAppearance = OverlayStyleAppearance()

open class OverlayStyleAppearance {
    open var style: ShapeStyle = .box
    open var styleColor = UIColor.lightGray
    open var backgroundColor = UIColor.clear
    open var backgroundInsets: UIEdgeInsets = UIEdgeInsets.zero

    open var borderWidth: CGFloat = 0
    open var borderColor: UIColor = UIColor.black
    
    public init() {
    }
    
    public init(style: ShapeStyle, styleColor: UIColor, backgroundColor: UIColor, borderColor: UIColor, borderWidth: CGFloat) {
        self.style = style
        self.styleColor = styleColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.backgroundColor = backgroundColor
    }
}
