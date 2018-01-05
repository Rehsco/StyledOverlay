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

class MenuItemStyler: FlexCellStyler {
    var configuration: StyledMenuPopoverConfiguration = StyledMenuPopoverConfiguration()

    init(configuration: StyledMenuPopoverConfiguration) {
        self.configuration = configuration
    }
    
    func prepareStyle(forCell cell: FlexCollectionViewCell) {
    }
    
    func applyStyle(toCell cell: FlexCollectionViewCell) {
        if let baseCell = cell as? FlexBaseCollectionViewCell {
            baseCell.textLabel?.labelTextAlignment = self.configuration.menuItemTextAlignment
        }
    }
}

class TitleItemStyler: FlexCellStyler {
    var configuration: StyledMenuPopoverConfiguration = StyledMenuPopoverConfiguration()
    
    init(configuration: StyledMenuPopoverConfiguration) {
        self.configuration = configuration
    }
    
    func prepareStyle(forCell cell: FlexCollectionViewCell) {
        if let tvCell = cell as? FlexTextViewCollectionViewCell {
            tvCell.styleColor = .clear
        }
    }
    
    func applyStyle(toCell cell: FlexCollectionViewCell) {
        if let tvCell = cell as? FlexTextViewCollectionViewCell {
            tvCell.textLabel?.labelTextAlignment = self.configuration.menuItemTextAlignment
            tvCell.textView?.textAlignment = self.configuration.menuSubTitleTextAlignment
        }
    }
}

class CloseButtonStyler: FlexCellStyler {
    var configuration: StyledMenuPopoverConfiguration = StyledMenuPopoverConfiguration()
    
    init(configuration: StyledMenuPopoverConfiguration) {
        self.configuration = configuration
    }
    
    func prepareStyle(forCell cell: FlexCollectionViewCell) {
    }
    
    func applyStyle(toCell cell: FlexCollectionViewCell) {
        if let baseCell = cell as? FlexBaseCollectionViewCell {
            baseCell.textLabel?.labelTextAlignment = self.configuration.closeButtonTextAlignment
        }
    }
}

open class StyledMenuPopover: UIView {
    public var configuration: StyledMenuPopoverConfiguration = StyledMenuPopoverConfiguration()
    open var menuItems: [FlexCollectionItem] = []
    
    open var menuView: FlexCollectionView?

    open var minimumHeight: CGFloat = 100
    open var preferredSize: CGSize = CGSize(width: 200, height: 200)
    /// The maximum allowed cells arranged horizontally
    open var numCellsHorizontal = 4
    
    var title: NSAttributedString = NSAttributedString()
    var subTitle: NSAttributedString? = nil
    
    var headerSectionRef: String? = nil
    var itemSectionRef: String? = nil
    var headerItem: FlexCollectionItem? = nil

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
            
            menuView.centerCellsHorizontally = true
        }
    }
    
    // MARK: - Public interface
    
    open func addMenuItem(_ item: FlexCollectionItem) {
        self.menuItems.append(item)
    }
    
    open func show(title: NSAttributedString, subTitle: NSAttributedString?, topLeftPoint: CGPoint? = nil, icon: UIImage? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.populateMenu() {
            // TODO: change when animation is done
            //        self.menuView?.alpha = 0
            // TODO: calculate correct offset in animation
            let ms = self.calculateMenuSize()
            let mo = CGPoint(x: (self.frame.width - ms.width) * 0.5, y: (self.frame.height - ms.height) * 0.5)
            if let mv = self.menuView {
                mv.frame = CGRect(origin: mo, size: ms)
                mv.headerAttributedText = title
                if let icon = icon {
                    mv.header.imageView.image = icon
                    mv.header.imageViewPosition = self.configuration.headerIconPosition
                    mv.header.imageViewOffset = CGPoint(x: self.configuration.headerIconRelativeOffset.x * icon.size.width, y: self.configuration.headerIconRelativeOffset.y * self.configuration.headerHeight)
                    
                    mv.header.imageView.layer.masksToBounds = self.configuration.headerIconClipToBounds
                    mv.header.imageView.layer.cornerRadius = icon.size.width * 0.5
                    mv.header.imageView.backgroundColor = self.configuration.headerIconBackgroundColor
                    mv.header.imageView.layer.borderColor = self.configuration.headerIconBorderColor.cgColor
                    mv.header.imageView.layer.borderWidth = self.configuration.headerIconBorderWidth
                    
                    mv.header.imageView.isHidden = false
                }
                self.addSubview(self.menuView!)
                self.animateIn()
            }
            
            let rv = UIApplication.shared.keyWindow! as UIWindow
            self.backgroundColor = self.configuration.backgroundTintColor
            rv.addSubview(self)

            if self.configuration.tapOutsideViewToClose {
                let tgr = UITapGestureRecognizer(target: self, action: #selector(self.tappedOutsideHandler(_:)))
                self.addGestureRecognizer(tgr)
            }
        }
    }

    @objc public func tappedOutsideHandler(_ sender: Any) {
        self.hide()
    }
    
    open func hide() {
        self.animateOut()

        // TODO: Remove this when animations are implemented
        DispatchQueue.main.async {
            self.removeFromSuperview()
        }
    }

    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        // TODO
    }
    
    open func calculateMenuSize() -> CGSize {
        // TODO: Title must be considered also
        if let mv = self.menuView {
            let size = self.preferredSize
            let headerSize = self.getHeaderSectionSize()
            
            let collMargins = mv.viewMargins
            let totalCells = mv.itemCollectionView.numberOfItems(inSection: 1)
            let itemSize = self.configuration.menuItemSize
            
            let widthPerItem = itemSize.width + self.getHorizontalSectionInset()
            let rowWidth = size.width - (collMargins.left + collMargins.right)
            let numRowItems = max(Int(floor(rowWidth / widthPerItem)), 1)
            let itemsHorizontally = max(min(self.numCellsHorizontal, numRowItems), 1)
            
            let totalWidth = max(CGFloat(itemsHorizontally) * widthPerItem, headerSize.width) + (collMargins.left + collMargins.right) + mv.itemCollectionView.contentInset.left + mv.itemCollectionView.contentInset.right
            
            let numRows = max(1, totalCells / numRowItems)
            let rowHeight = itemSize.height + self.getVerticalSectionInset()
            
            let headerAndFooterHeight = self.configuration.headerHeight + (self.configuration.showFooter ? self.configuration.footerHeight : 0)
            let totalHeight = CGFloat(numRows) * rowHeight + (collMargins.top + collMargins.bottom) + headerAndFooterHeight + headerSize.height
            
            return CGSize(width: totalWidth, height: totalHeight)
        }
        return self.preferredSize
    }
    
    private func getHeaderSectionSize() -> CGSize {
        let baseSize:CGSize = CGSize(width: self.getHorizontalSectionInset(), height: self.getVerticalSectionInset())
        if let hi = self.headerItem {
            let cs = hi.preferredCellSize ?? .zero
            return CGSize(width: cs.width + baseSize.width, height: cs.height + baseSize.height)
        }
        return baseSize
    }
    
    private func getHorizontalSectionInset() -> CGFloat {
        if let layout = self.menuView?.itemCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let inset = layout.sectionInset
            return inset.left + inset.right + layout.minimumInteritemSpacing
        }
        return 0
    }
    
    private func getVerticalSectionInset() -> CGFloat {
        if let layout = self.menuView?.itemCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let inset = layout.sectionInset
            return inset.top + inset.bottom + layout.minimumLineSpacing
        }
        return 0
    }
    
    // MARK: - View Model
    
    open func populateMenu(completion: @escaping (()->Void)) {
        DispatchQueue.main.async {
            if let mv = self.menuView {
                mv.removeAllSections()
                // TODO: add title item I/A

                self.headerSectionRef = mv.addSection()
                if let subTitle = self.subTitle, let hsr = self.headerSectionRef {
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.alignment = self.configuration.menuSubTitleTextAlignment
                    let attributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.paragraphStyle: paragraph]
                    let nas = NSMutableAttributedString(attributedString: subTitle)
                    nas.addAttributes(attributes, range: NSMakeRange(0, nas.length))
                    let sti = FlexTextViewCollectionItem(reference: UUID().uuidString, text: nas, title: nil)
                    let collMargins = mv.viewMargins
                    let width = self.preferredSize.width - (collMargins.left + collMargins.top + mv.itemCollectionView.contentInset.left + mv.itemCollectionView.contentInset.right)
                    let height = nas.heightWithConstrainedWidth(width)
                    sti.preferredCellSize = CGSize(width: width, height: height + 10)
                    sti.autoDeselectCellAfter = .milliseconds(200)
                    sti.autodetectRTLTextAlignment = false
                    sti.cellStyler = TitleItemStyler(configuration: self.configuration)
                    sti.canMoveItem = false
                    mv.addItem(hsr, item: sti)
                    self.headerItem = sti
                }

                self.itemSectionRef = mv.addSection()
                if let msr = self.itemSectionRef {
                    for mi in self.menuItems {
                        mi.autoDeselectCellAfter = .milliseconds(200)
                        mi.cellStyler = MenuItemStyler(configuration: self.configuration)
                        mi.canMoveItem = false
                        mv.addItem(msr, item: mi)
                    }
                    
                    if self.configuration.closeButtonEnabled {
                        let closeMI = FlexBaseCollectionItem(reference: UUID().uuidString, text: self.configuration.closeButtonText)
                        closeMI.itemSelectionActionHandler = {
                            self.hide()
                        }
                        closeMI.autoDeselectCellAfter = .milliseconds(200)
                        closeMI.cellStyler = CloseButtonStyler(configuration: self.configuration)
                        closeMI.canMoveItem = false
                        mv.addItem(msr, item: closeMI)
                    }
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
