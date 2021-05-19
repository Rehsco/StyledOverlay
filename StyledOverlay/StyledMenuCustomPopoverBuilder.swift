//
//  StyledMenuCustomPopoverBuilder.swift
//  StyledOverlay
//
//  Created by Martin Rehder on 08.02.2019.
/*
 * Copyright 2019-present Martin Jacob Rehder.
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
import FlexMenu

open class StyledMenuCustomPopoverBuilder {
    private let configuration: StyledMenuPopoverConfiguration
    private let popover: StyledMenuPopover
    
    public init() {
        self.configuration = StyledMenuPopoverFactory.defaultConvenienceMenuConfiguration()
        self.popover = StyledMenuPopover(frame: UIScreen.main.bounds, configuration: configuration)
    }
    
    public init(withConfiguration configuration: StyledMenuPopoverConfiguration) {
        self.configuration = configuration
        self.popover = StyledMenuPopover(frame: UIScreen.main.bounds, configuration: configuration)
    }
    
    @discardableResult
    public func addButton(text: String, tapHandler: (() -> Void)? = nil) -> StyledMenuCustomPopoverBuilder {
        StyledMenuPopoverFactory.addStandardButton(popover: popover, text: text, configuration: configuration, tapHandler: tapHandler)
        return self
    }

    @discardableResult
    public func addStandardCancelButton(tapHandler: (() -> Void)? = nil) -> StyledMenuCustomPopoverBuilder {
        StyledMenuPopoverFactory.addStandardCancelButton(popover: popover, configuration: configuration, tapHandler: tapHandler)
        return self
    }
    
    @discardableResult
    public func show(title: NSAttributedString, subTitle: NSAttributedString?, topLeftPoint: CGPoint? = nil, icon: UIImage? = nil) -> StyledMenuCustomPopoverBuilder {
        popover.show(title: title, subTitle: subTitle, topLeftPoint: topLeftPoint, icon: icon)
        return self
    }

    @discardableResult
    public func show(title: String, subTitle: String?, topLeftPoint: CGPoint? = nil, icon: UIImage? = nil) -> StyledMenuCustomPopoverBuilder {
        popover.show(title: title, subTitle: subTitle, topLeftPoint: topLeftPoint, icon: icon)
        return self
    }

    @discardableResult
    public func hide() -> StyledMenuCustomPopoverBuilder {
        popover.hide()
        return self
    }
    
}
