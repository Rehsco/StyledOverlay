//
//  MenuItemStyler.swift
//  StyledOverlay
//
//  Created by Martin Rehder on 08.01.2018.
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
import FlexCollections

open class MenuItemStyler: StyledOverlayCellStyler {
    open override func prepareStyle(forCell cell: FlexCollectionViewCell) {
        if let baseCell = cell as? FlexBaseCollectionViewCell {
            baseCell.flexContentView?.style = self.configuration.menuItemStyle
            baseCell.flexContentView?.styleColor = self.configuration.menuItemStyleColor
            baseCell.style = self.configuration.menuItemStyle
            baseCell.styleColor = self.configuration.menuItemStyleColor
            baseCell.flexContentView?.footer.caption.labelTextAlignment = self.configuration.menuItemTextAlignment
        }
    }
    
    open override func applyStyle(toCell cell: FlexCollectionViewCell) {
        if let baseCell = cell as? FlexBaseCollectionViewCell {
            baseCell.textLabel?.labelTextAlignment = self.configuration.menuItemTextAlignment
        }
    }
}
