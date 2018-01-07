//
//  StyledMenuPopoverConfiguration.swift
//  StyledOverlay
//
//  Created by Martin Rehder on 01.01.2018.
/*
 * Copyright 2018-present Martin Jacob Rehder.
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
import MJRFlexStyleComponents

open class StyledMenuPopoverConfiguration {
    
    public init() {}
    
    /// Features
    open var tapOutsideViewToClose: Bool = true
    
    /// General Styling
    open var backgroundTintColor: UIColor = UIColor.black.withAlphaComponent(0.6)
    
    open var style: FlexShapeStyle = FlexShapeStyle(style: .roundedFixed(cornerRadius: 10))
    open var styleColor: UIColor = .lightGray
    open var borderWidth: CGFloat = 0
    open var borderColor: UIColor = .black
    open var contentMargins: UIEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
    open var menuItemSize: CGSize = CGSize(width: 64, height: 80)
    open var displayType: FlexCollectionCellDisplayMode = .iconified(size: CGSize(width: 64, height: 80))

    open var appearAnimation: StyledOverlayAnimationStyle = .bottomToTop
    open var disappearAnimation: StyledOverlayAnimationStyle = .fadeInOut
    open var animationDuration: TimeInterval = 0.2

    open var showTitleInHeader: Bool = true
    open var titleHeightWhenNotInHeader: CGFloat = 26

    open var closeButtonEnabled: Bool = true
    open var closeButtonText: NSAttributedString = NSAttributedString(string: "Close")
    open var closeButtonTextAlignment: NSTextAlignment = .center
    open var closeButtonStyle: FlexShapeStyle = FlexShapeStyle(style: .roundedFixed(cornerRadius: 10))
    open var closeButtonStyleColor: UIColor = .gray

    /// Header
    open var detachedHeader: Bool = false
    open var headerFont: UIFont? = nil
    open var headerTextColor: UIColor? = nil
    open var headerTextAlignment: NSTextAlignment = .center
    open var headerStyleColor: UIColor = .gray
    open var headerHeight: CGFloat = 32

    /// Header Icon
    open var headerIconPosition: NSTextAlignment = .center
    open var headerIconRelativeOffset: CGPoint = CGPoint(x: 0, y: -0.5) // x is relative to icon width, y is relative to headerHeight
    open var headerIconClipToBounds: Bool = true
    open var headerIconBackgroundColor: UIColor = .lightGray
    open var headerIconBorderColor: UIColor = .clear
    open var headerIconBorderWidth: CGFloat = 0

    /// Footer
    open var showFooter: Bool = false
    open var detachedFooter: Bool = false
    open var footerFont: UIFont? = nil
    open var footerTextColor: UIColor? = nil
    open var footerTextAlignment: NSTextAlignment = .center
    open var footerStyleColor: UIColor = .lightGray
    open var footerHeight: CGFloat = 20

    /// Menu item styling
    open var menuItemTextAlignment: NSTextAlignment = .center
    open var menuSubTitleTextAlignment: NSTextAlignment = .center
    open var menuItemStyle: FlexShapeStyle = FlexShapeStyle(style: .roundedFixed(cornerRadius: 10))
    open var menuItemStyleColor: UIColor = .gray
    open var menuItemSectionMargins: UIEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 0)

}
