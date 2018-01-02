//
//  StyledMenuPopover.swift
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
import MJRFlexStyleComponents

open class StyledMenuPopover: UIView {
    public var configuration: StyledMenuPopoverConfiguration = StyledMenuPopoverConfiguration()
    open var menuItems: [FlexCollectionItem] = []
    
    open var menuView: FlexCollectionView?

    open var minimumHeight: CGFloat = 150
    open var preferredSize: CGSize = CGSize(width: 320, height: 200)
    
    var title: NSAttributedString = NSAttributedString()
    var subTitle: NSAttributedString? = nil
    
    // TODO: header icon
    // TODO: close action closure

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    public init(frame: CGRect, configuration: StyledMenuPopoverConfiguration) {
        self.configuration = configuration
        super.init(frame: frame)
        self.setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    // MARK: - Initializations
    
    private func setupView() {
        self.menuView = FlexCollectionView(frame: CGRect(origin: .zero, size: self.preferredSize))
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        if let menuView = self.menuView {
            menuView.defaultCellSize = self.configuration.menuItemSize
            menuView.styleColor = self.configuration.styleColor
            menuView.style = self.configuration.style
            menuView.cellDisplayMode = self.configuration.displayType

            // TODO: Borders
            
            menuView.header.caption.labelTextAlignment = self.configuration.headerTextAlignment
            menuView.header.caption.labelFont = self.configuration.headerFont
            menuView.header.caption.labelTextColor = self.configuration.headerTextColor
            menuView.headerSize = self.configuration.headerHeight
            menuView.header.styleColor = self.configuration.headerStyleColor

            menuView.footer.caption.labelTextAlignment = self.configuration.footerTextAlignment
            menuView.footer.caption.labelFont = self.configuration.footerFont
            menuView.footer.caption.labelTextColor = self.configuration.footerTextColor
            menuView.footerSize = self.configuration.footerHeight
            menuView.footer.styleColor = self.configuration.footerStyleColor
        }
    }
    
    // MARK: - Public interface
    
    open func addMenuItem(_ item: FlexCollectionItem) {
        self.menuItems.append(item)
    }
    
    open func show(title: NSAttributedString, subTitle: NSAttributedString?, topLeftPoint: CGPoint? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.populateMenu() {
            // TODO: change when animation is done
            //        self.menuView?.alpha = 0
            // TODO: calculate correct offset in animation
            let ms = self.calculateMenuSize()
            let mo = CGPoint(x: (self.frame.width - ms.width) * 0.5, y: (self.frame.height - ms.height) * 0.5)
            self.menuView?.frame = CGRect(origin: mo, size: ms)
            self.menuView?.headerAttributedText = title
            self.addSubview(self.menuView!)
            self.animateIn()
            
            let rv = UIApplication.shared.keyWindow! as UIWindow
            self.backgroundColor = self.configuration.backgroundTintColor
            rv.addSubview(self)
            
            // TODO: Add tap gesture on "this" for potentional cancel viewing
        }
    }

    open func hide() {
        self.animateOut()
    }

    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        // TODO
    }
    
    open func calculateMenuSize() -> CGSize {
        // TODO
        return self.preferredSize
    }
    
    // MARK: - View Model
    
    open func populateMenu(completion: @escaping (()->Void)) {
        DispatchQueue.main.async {
            if let mv = self.menuView {
                mv.removeAllSections()
                // TODO: add close and title/subtitle items
                let msr = mv.addSection()
                for mi in self.menuItems {
                    mi.autoDeselectCellAfter = .milliseconds(250)
                    mv.addItem(msr, item: mi)
                }
                mv.itemCollectionView.reloadData()
                completion()
            }
        }
    }
    
    // MARK: - Animations
    
    open func animateIn() {
        // TODO

    }

    open func animateOut() {
        // TODO

    }
    
    // MARK: - Keyboard handling for input field popovers
    
}
