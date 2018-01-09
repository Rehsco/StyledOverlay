//
//  StyledMenuPopoverFactory.swift
//  StyledOverlay
//
//  Created by Martin Rehder on 02.01.2018.
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
import MJRFlexStyleComponents

open class StyledMenuPopoverFactory {

    open class func showSimpleMenu(title: NSAttributedString, subTitle: NSAttributedString? = nil, items: [FlexCollectionItem], preferredSize: CGSize = CGSize(width: 200, height: 200)) {
        DispatchQueue.main.async {
            let simpleConfig = StyledMenuPopoverConfiguration()
            simpleConfig.menuItemSize = CGSize(width: 200, height: 40)
            simpleConfig.displayType = .normal
            let menu = StyledMenuPopover(frame: UIScreen.main.bounds, configuration: simpleConfig)
            menu.preferredSize = preferredSize
            for mi in items {
                menu.addMenuItem(mi)
            }
            menu.show(title: title, subTitle: subTitle)
        }
    }
    
    open class func showMenuWithIcon(title: NSAttributedString, subTitle: NSAttributedString? = nil, items: [FlexCollectionItem], icon: UIImage, preferredSize: CGSize = CGSize(width: 200, height: 200)) {
        DispatchQueue.main.async {
            let simpleConfig = StyledMenuPopoverConfiguration()
            simpleConfig.menuItemSize = CGSize(width: 200, height: 40)
            simpleConfig.displayType = .normal
            simpleConfig.showTitleInHeader = false
            let menu = StyledMenuPopover(frame: UIScreen.main.bounds, configuration: simpleConfig)
            menu.preferredSize = preferredSize
            for mi in items {
                menu.addMenuItem(mi)
            }
            menu.show(title: title, subTitle: subTitle, icon: icon)
        }
    }

    open class func showIconMenu(title: NSAttributedString, subTitle: NSAttributedString? = nil, items: [FlexCollectionItem], preferredSize: CGSize = CGSize(width: 200, height: 200)) {
        DispatchQueue.main.async {
            let simpleConfig = StyledMenuPopoverConfiguration()
            simpleConfig.closeButtonEnabled = false
            let menu = StyledMenuPopover(frame: UIScreen.main.bounds, configuration: simpleConfig)
            menu.preferredSize = preferredSize
            for mi in items {
                menu.addMenuItem(mi)
            }
            menu.show(title: title, subTitle: subTitle)
        }
    }

    open class func showCustomMenu(title: NSAttributedString, subTitle: NSAttributedString? = nil, configuration: StyledMenuPopoverConfiguration = StyledMenuPopoverConfiguration(), items: [FlexCollectionItem], icon: UIImage? = nil, preferredSize: CGSize = CGSize(width: 200, height: 200)) {
        DispatchQueue.main.async {
            let menu = StyledMenuPopover(frame: UIScreen.main.bounds, configuration: configuration)
            menu.preferredSize = preferredSize
            for mi in items {
                menu.addMenuItem(mi)
            }
            menu.show(title: title, subTitle: subTitle, icon: icon)
        }
    }
    
}
