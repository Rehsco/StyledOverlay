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

    open var minimumHeight: CGFloat = 100
    open var preferredSize: CGSize = CGSize(width: 200, height: 200)
    /// The maximum allowed cells arranged horizontally
    open var numCellsHorizontal = 4
    
    public var titleItemStyler: StyledOverlayCellStyler?
    public var menuItemStyler: StyledOverlayCellStyler?
    public var closeButtonStyler: StyledOverlayCellStyler?

    var menuInitializing = true
    
    var title: NSAttributedString = NSAttributedString()
    var subTitle: NSAttributedString? = nil
    var menuIcon: UIImage? = nil
    
    var headerSectionRef: String? = nil
    var itemSectionRef: String? = nil
    var headerItem: FlexCollectionItem? = nil

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
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self)
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }

    // MARK: - Initializations
    
    private func setupView() {
        self.titleItemStyler = TitleItemStyler(configuration: self.configuration)
        self.menuItemStyler = MenuItemStyler(configuration: self.configuration)
        self.closeButtonStyler = CloseButtonStyler(configuration: self.configuration)

        self.menuView = FlexCollectionView(frame: CGRect(origin: .zero, size: self.preferredSize))
        self.setupCollectionView()
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.orientationChanged(notification:)),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func orientationChanged(notification: Notification) {
        self.frame = UIScreen.main.bounds
        self.setNeedsLayout()
    }

    private func setupCollectionView() {
        if let menuView = self.menuView {
            menuView.defaultCellSize = self.configuration.menuItemSize
            menuView.styleColor = self.configuration.styleColor
            menuView.style = self.configuration.style
            menuView.cellDisplayMode = self.configuration.displayType

            menuView.borderWidth = self.configuration.borderWidth
            menuView.borderWidth = self.configuration.borderWidth

            menuView.viewMargins = self.configuration.contentMargins
            
            menuView.header.caption.labelTextAlignment = self.configuration.headerTextAlignment
            menuView.header.caption.labelFont = self.configuration.headerFont
            menuView.header.caption.labelTextColor = self.configuration.headerTextColor
            menuView.headerSize = self.configuration.headerHeight
            if self.configuration.showHeader {
                menuView.header.styleColor = self.configuration.headerStyleColor
            }
            else {
                menuView.header.styleColor = .clear
            }

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
    
    open func show(title: String, subTitle: String?, topLeftPoint: CGPoint? = nil, icon: UIImage? = nil) {
        let styledTitle = NSAttributedString(font: self.configuration.headerFont, color: self.configuration.headerTextColor, text: title)
        let styledSubTitle = subTitle != nil ? NSAttributedString(font: self.configuration.menuSubtitleFont, color: self.configuration.menuSubtitleTextColor, text: subTitle!) : nil
        show(title: styledTitle, subTitle: styledSubTitle, topLeftPoint: topLeftPoint, icon: icon)
    }
    
    open func show(title: NSAttributedString, subTitle: NSAttributedString?, topLeftPoint: CGPoint? = nil, icon: UIImage? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.menuIcon = icon
        let rv = UIApplication.shared.keyWindow! as UIWindow
        self.backgroundColor = self.configuration.backgroundTintColor
        self.alpha = 0
        rv.addSubview(self)
        
        if self.configuration.tapOutsideViewToClose {
            let tgr = UITapGestureRecognizer(target: self, action: #selector(self.tappedOutsideHandler(_:)))
            self.addGestureRecognizer(tgr)
        }
        self.menuInitializing = true
        self.populateMenu() {
            self.layoutMenuView()
            self.addSubview(self.menuView!)
            self.animateIn()
        }
    }

    @objc public func tappedOutsideHandler(_ sender: Any) {
        self.hide()
    }
    
    open func hide() {
        self.animateOut()
    }

    // MARK: - Layout
    
    open func layoutMenuView() {
        let menuSize = self.calculateMenuSize()
        let menuOriginPoint = CGPoint(x: (self.frame.width - menuSize.width) * 0.5, y: (self.frame.height - menuSize.height) * 0.5)
        if let mv = self.menuView {
            mv.frame = CGRect(origin: menuOriginPoint, size: menuSize)
            if self.configuration.showTitleInHeader && self.configuration.showHeader {
                mv.headerAttributedText = title
            }
            else if self.menuIcon != nil {
                mv.headerAttributedText = NSAttributedString()
            }
            if let icon = self.menuIcon {
                let iconSize = self.configuration.headerIconSize ?? icon.size
                mv.header.imageViewSize = iconSize
                mv.header.imageView.image = icon
                mv.header.imageView.contentMode = .center
                mv.header.imageViewPosition = self.configuration.headerIconPosition
                mv.header.imageViewOffset = CGPoint(x: self.configuration.headerIconRelativeOffset.x * iconSize.width, y: self.configuration.headerIconRelativeOffset.y * self.configuration.headerHeight)
                
                mv.header.imageView.layer.masksToBounds = self.configuration.headerIconClipToBounds
                mv.header.imageView.layer.cornerRadius = iconSize.width * 0.5
                mv.header.imageView.backgroundColor = self.configuration.headerIconBackgroundColor
                mv.header.imageView.layer.borderColor = self.configuration.headerIconBorderColor.cgColor
                mv.header.imageView.layer.borderWidth = self.configuration.headerIconBorderWidth
                
                mv.header.imageView.isHidden = false
            }
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if !self.menuInitializing {
            self.populateMenu() {
                self.layoutMenuView()
            }
        }
        else {
            self.menuInitializing = false
        }
    }
    
    open func calculateMenuSize() -> CGSize {
        if let mv = self.menuView {
            let headerSize = self.getHeaderSectionSize()
            
            let collMargins = mv.viewMargins
            let totalCells = mv.itemCollectionView.numberOfItems(inSection: 1)
            let itemSize = self.configuration.menuItemSize

            let numRowItems = min(calculateFittingCellsPerRow(), totalCells)
            let itemsHorizontally = max(min(self.numCellsHorizontal, numRowItems), 1)
            
            let totalItemSpacing = (self.getHorizontalSpacing() * CGFloat(itemsHorizontally-1) )
            let totalWidth = max(CGFloat(itemsHorizontally) * itemSize.width + totalItemSpacing + self.getHorizontalSectionInset(1), headerSize.width) + (collMargins.left + collMargins.right) + mv.itemCollectionView.contentInset.left + mv.itemCollectionView.contentInset.right
            
            let numRows = totalCells < itemsHorizontally ? 1 : Int(ceil(Double(totalCells) / Double(itemsHorizontally)))
            
            let headerAndFooterHeight = (self.configuration.showHeader || self.menuIcon != nil ? self.configuration.headerHeight : 0) + (self.configuration.showFooter ? self.configuration.footerHeight : 0)
            let totalHeight = (CGFloat(numRows) * (itemSize.height + self.getItemLineSpacing()) + (collMargins.top + collMargins.bottom) + headerAndFooterHeight + headerSize.height) - self.getItemLineSpacing() + self.getVerticalSectionInset(1)
            
            return CGSize(width: totalWidth, height: totalHeight)
        }
        return self.preferredSize
    }
    
    private func calculateFittingCellsPerRow() -> Int {
        if let mv = self.menuView {
            let size = self.preferredSize
            let collMargins = mv.viewMargins
            let itemWidth = self.configuration.menuItemSize.width
            let horizontalSpacing = self.getHorizontalSpacing()

            var rowWidth: CGFloat = 0
            if #available(iOS 11.0, *) {
                rowWidth = size.width - (collMargins.left + collMargins.right + mv.itemCollectionView.safeAreaInsets.left + mv.itemCollectionView.safeAreaInsets.right)
            } else {
                rowWidth = size.width - (collMargins.left + collMargins.right)
            }
            rowWidth -= self.getHorizontalSectionInset(1)

            var cellsFittingInRow = 0
            if rowWidth >= itemWidth {
                cellsFittingInRow = 1
                var rowSpaceLeft = rowWidth - itemWidth
                while rowSpaceLeft >= itemWidth + horizontalSpacing {
                    rowSpaceLeft -= itemWidth + horizontalSpacing
                    cellsFittingInRow += 1
                }
            }
            return cellsFittingInRow
        }
        return 0
    }
    
    private func getHeaderSectionSize() -> CGSize {
        let baseSize:CGSize = CGSize(width: self.getHorizontalSectionInset(0), height: self.getVerticalSectionInset(0))
        if let hi = self.headerItem {
            let cs = hi.preferredCellSize ?? .zero
            return CGSize(width: cs.width + baseSize.width, height: cs.height + baseSize.height)
        }
        return baseSize
    }
    
    private func getHorizontalSectionInset(_ sectionIdx: Int) -> CGFloat {
        if let layout = self.menuView?.itemCollectionView.collectionViewLayout as? UICollectionViewFlowLayout, let section = self.menuView?.getSection(atIndex: sectionIdx) {
            let inset = layout.sectionInset
            let sInset = section.insets
            return inset.left + inset.right + sInset.left + sInset.right
        }
        return 0
    }
    
    private func getVerticalSectionInset(_ sectionIdx: Int) -> CGFloat {
        if let layout = self.menuView?.itemCollectionView.collectionViewLayout as? UICollectionViewFlowLayout, let section = self.menuView?.getSection(atIndex: sectionIdx) {
            let inset = layout.sectionInset
            let sInset = section.insets
            return inset.top + inset.bottom + sInset.top + sInset.bottom
        }
        return 0
    }
    
    private func getItemLineSpacing() -> CGFloat {
        if let layout = self.menuView?.itemCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            return layout.minimumLineSpacing
        }
        return 0
    }

    private func getInterItemSpacing() -> CGFloat {
        if let layout = self.menuView?.itemCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            return layout.minimumInteritemSpacing
        }
        return 0
    }
    
    private func getHorizontalSpacing() -> CGFloat {
        if let layout = self.menuView?.itemCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            return layout.scrollDirection == .vertical ? layout.minimumInteritemSpacing : layout.minimumLineSpacing
        }
        return 0
    }
    
    // MARK: - View Model
    
    open func populateMenu(completion: @escaping (()->Void)) {
        DispatchQueue.main.async {
            if let menuView = self.menuView {
                menuView.removeAllSections()

                self.headerSectionRef = menuView.addSection()
                if let headerSectionRef = self.headerSectionRef, let topCellItemWithTitle = self.createTopCellItemWithTitle() {
                    menuView.addItem(headerSectionRef, item: topCellItemWithTitle)
                    self.headerItem = topCellItemWithTitle
                }

                self.itemSectionRef = menuView.addSection(nil, height: nil, insets: self.configuration.menuItemSectionMargins)
                if let itemSectionRef = self.itemSectionRef {
                    for mi in self.menuItems {
                        self.assignDefaultMenuItemSettings(mi)
                        mi.cellStyler = self.menuItemStyler
                        menuView.addItem(itemSectionRef, item: mi)
                    }
                    
                    if self.configuration.closeButtonEnabled {
                        let closeMI = self.createCloseButtonMenuItem()
                        menuView.addItem(itemSectionRef, item: closeMI)
                    }
                }

                menuView.itemCollectionView.reloadData()
                completion()
            }
        }
    }
    
    private func createCloseButtonMenuItem() -> FlexBaseCollectionItem {
        let closeMI = FlexBaseCollectionItem(reference: UUID().uuidString, text: self.configuration.closeButtonText)
        closeMI.itemSelectionActionHandler = {
            self.hide()
        }
        self.assignDefaultMenuItemSettings(closeMI)
        closeMI.cellStyler = self.closeButtonStyler
        return closeMI
    }
    
    private func createTopCellItemWithTitle() -> FlexTextViewCollectionItem? {
        let width = self.preferredSize.width
        
        var topCellItemWithTitle: FlexTextViewCollectionItem?
        var topCellHeight: CGFloat = 0
        if let subTitle = self.subTitle {
            let styledSubTitle = subTitle.applyParagraphStyle(textAlignment: self.configuration.menuSubTitleTextAlignment)
            topCellItemWithTitle = FlexTextViewCollectionItem(reference: UUID().uuidString, text: styledSubTitle)
            topCellItemWithTitle?.textTitle = self.configuration.showTitleInHeader ? nil : self.title
            topCellHeight = styledSubTitle.heightWithConstrainedWidth(width) + (self.configuration.showTitleInHeader ? 0 : self.configuration.titleHeightWhenNotInHeader)
        }
        else if !self.configuration.showTitleInHeader {
            topCellItemWithTitle = FlexTextViewCollectionItem(reference: UUID().uuidString, text: NSAttributedString())
            topCellItemWithTitle?.textTitle = self.title
            topCellHeight = max(self.title.heightWithConstrainedWidth(width), self.configuration.titleHeightWhenNotInHeader)
        }
        
        if let topCellItemWithTitle = topCellItemWithTitle {
            topCellItemWithTitle.preferredCellSize = CGSize(width: width, height: topCellHeight + 10)
            self.assignDefaultMenuItemSettings(topCellItemWithTitle)
            topCellItemWithTitle.autodetectRTLTextAlignment = false
            topCellItemWithTitle.cellStyler = self.titleItemStyler
        }
        return topCellItemWithTitle
    }
    
    open func assignDefaultMenuItemSettings(_ menuItem: FlexCollectionItem) {
        menuItem.autoDeselectCellAfter = .milliseconds(200)
        menuItem.canMoveItem = false
        if let bmi = menuItem as? FlexBaseCollectionItem {
            bmi.contentInteractionWillSelectItem = true
        }
    }
    
    // MARK: - Animations
    
    open func animateIn() {
        self.alpha = 0
        UIView.animate(withDuration: self.configuration.animationDuration) {
            self.alpha = 1
        }
        StyledOverlayAnimator.showAnimation(forView: self.menuView!, direction: .ingoing, animationStyle: self.configuration.appearAnimation, animationDuration: self.configuration.animationDuration)
    }

    open func animateOut() {
        UIView.animate(withDuration: self.configuration.animationDuration) {
            self.alpha = 0
        }
        StyledOverlayAnimator.showAnimation(forView: self.menuView!, direction: .outgoing, animationStyle: self.configuration.disappearAnimation, animationDuration: self.configuration.animationDuration) {
            DispatchQueue.main.async {
                self.removeFromSuperview()
            }
        }
    }
    
    // MARK: - Keyboard handling for input field popovers
    
    var tmpContentViewFrameOrigin: CGPoint?
    var keyboardHasBeenShown:Bool = false
    
    @objc func keyboardWillShow(_ notification: Notification) {
        keyboardHasBeenShown = true
        
        guard let userInfo = (notification as NSNotification).userInfo else {return}
        guard let endKeyBoardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.minY else {return}
        guard let menuView = self.menuView else { return }
        
        if tmpContentViewFrameOrigin == nil {
            tmpContentViewFrameOrigin = menuView.frame.origin
        }
        
        var newContentViewFrameY = menuView.frame.maxY - endKeyBoardFrame
        if newContentViewFrameY < 0 {
            newContentViewFrameY = 0
        }
        
        menuView.frame.origin.y -= newContentViewFrameY
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        guard let menuView = self.menuView else { return }

        if(keyboardHasBeenShown){//This could happen on the simulator (keyboard will be hidden)
            if let fOrigin = self.tmpContentViewFrameOrigin {
                menuView.frame.origin.y = fOrigin.y
                self.tmpContentViewFrameOrigin = nil
            }
            
            keyboardHasBeenShown = false
        }
    }
    
}
