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

    // MARK: - Simple Menu Creations
    
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

    // MARK: - Convenience Menu Creations
    
    open class func confirmation(title: String, subTitle: String, buttonText: String, iconName: String = "helpIcon_48pt", configuration: StyledMenuPopoverConfiguration = StyledMenuPopoverFactory.defaultConvenienceMenuConfiguration(), confirmationResult: @escaping ((Bool) -> Void)) {
        Thread.ensureOnAsyncMainThread {
            let image = (UIImage(named: iconName, in: Bundle(for: StyledMenuPopoverFactory.self), compatibleWith: nil) ?? UIImage(named: iconName))?.tint(configuration.headerIconTintColor)
            let thumbnailImage = image?.resized(newSize: image?.size)
            let popover = StyledMenuPopover(frame: UIScreen.main.bounds, configuration: configuration)
            self.addStandardButton(popover: popover, text: buttonText, configuration: configuration, tapHandler: {
                popover.hide()
                confirmationResult(true)
            })
            self.addStandardCancelButton(popover: popover, configuration: configuration) {
                confirmationResult(false)
            }
            let atitle = NSAttributedString(font: configuration.headerFont, color: configuration.headerTextColor, text: title)
            let asubtitle = NSAttributedString(font: configuration.menuSubtitleFont, color: configuration.menuSubtitleTextColor, text: subTitle)
            popover.show(title: atitle, subTitle: asubtitle, topLeftPoint: nil, icon: thumbnailImage)
        }
    }
    
    open class func showSettingsRequest(title: String, message: String, iconName: String = "CloseView_36pt", configuration: StyledMenuPopoverConfiguration = StyledMenuPopoverFactory.defaultConvenienceMenuConfiguration()) {
        Thread.ensureOnAsyncMainThread {
            let popover = StyledMenuPopover(frame: UIScreen.main.bounds, configuration: configuration)
            self.addStandardButton(popover: popover, text: NSLocalizedString("Open Settings", comment: ""), configuration: configuration, tapHandler: {
                popover.hide()
                if let url = URL(string:UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            })
            let image = (UIImage(named: iconName, in: Bundle(for: StyledMenuPopoverFactory.self), compatibleWith: nil) ?? UIImage(named: iconName))?.tint(configuration.headerIconTintColor)
            let thumbnailImage = image?.resized(newSize: image?.size)
            let atitle = NSAttributedString(font: configuration.headerFont, color: configuration.headerTextColor, text: title)
            let asubtitle = NSAttributedString(font: configuration.menuSubtitleFont, color: configuration.menuSubtitleTextColor, text: message)
            popover.show(title: atitle, subTitle: asubtitle, topLeftPoint: nil, icon: thumbnailImage)
        }
    }
    
    open class func showFailAlert(title: String, message: String, iconName: String = "InfoAlertIcon_48pt", configuration: StyledMenuPopoverConfiguration = StyledMenuPopoverFactory.defaultConvenienceMenuConfiguration(), okHandler: (() -> Void)? = nil) {
        Thread.ensureOnAsyncMainThread {
            let image = (UIImage(named: iconName, in: Bundle(for: StyledMenuPopoverFactory.self), compatibleWith: nil) ?? UIImage(named: iconName))?.tint(configuration.headerIconTintColor)
            let thumbnailImage = image?.resized(newSize: image?.size)
            let alertView = StyledMenuPopover(frame: UIScreen.main.bounds, configuration: configuration)
            self.addStandardButton(popover: alertView, text: NSLocalizedString("Ok", comment: ""), configuration: configuration, tapHandler: {
                alertView.hide()
                okHandler?()
            })
            let atitle = NSAttributedString(font: configuration.headerFont, color: configuration.headerTextColor, text: title)
            let asubtitle = NSAttributedString(font: configuration.menuSubtitleFont, color: configuration.menuSubtitleTextColor, text: message)
            alertView.show(title: atitle, subTitle: asubtitle, topLeftPoint: nil, icon: thumbnailImage)
        }
    }
    
    open class func queryForItemName(title: String, subtitle: String, textPlaceholder: String, iconName: String, configuration: StyledMenuPopoverConfiguration = StyledMenuPopoverFactory.defaultConvenienceMenuConfiguration(), completionHandler: @escaping ((String, Bool) -> Void)) {
        if let image = (UIImage(named: iconName, in: Bundle(for: StyledMenuPopoverFactory.self), compatibleWith: nil) ?? UIImage(named: iconName))?.tint(configuration.headerIconTintColor) {
            self.queryForItemName(title: title, subtitle: subtitle, textPlaceholder: textPlaceholder, image: image, configuration: configuration, completionHandler: completionHandler)
        }
        else {
            NSLog("You did not provide a correct name: \(iconName)")
        }
    }
    
    open class func queryForItemName(title: String, subtitle: String, textPlaceholder: String, image: UIImage, configuration: StyledMenuPopoverConfiguration = StyledMenuPopoverFactory.defaultConvenienceMenuConfiguration(), completionHandler: @escaping ((String, Bool) -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(50)) {
            let thumbnailImage = image.resized(newSize: configuration.headerIconSize)
            let popover = StyledMenuPopover(frame: UIScreen.main.bounds, configuration: configuration)
            
            let imenu = FlexTextFieldCollectionItem(reference: "textInput", text: NSAttributedString(string: ""))
            imenu.placeholderText = NSAttributedString(string: NSLocalizedString("Name", comment: ""))
            imenu.textFieldShouldReturn = {
                _ in
                return true
            }
            imenu.textIsMutable = true
            popover.addMenuItem(imenu)
            
            self.addStandardButton(popover: popover, text: NSLocalizedString("Done", comment: ""), configuration: configuration, tapHandler: {
                if let text = imenu.text?.string, text != "" {
                    completionHandler(text, true)
                }
                else {
                    completionHandler(textPlaceholder, true)
                }
            })
            addStandardCancelButton(popover: popover, configuration: configuration) {
                completionHandler("", false)
            }
            let atitle = NSAttributedString(font: configuration.headerFont, color: configuration.headerTextColor, text: title)
            let asubtitle = NSAttributedString(font: configuration.menuSubtitleFont, color: configuration.menuSubtitleTextColor, text: subtitle)
            popover.show(title: atitle, subTitle: asubtitle, topLeftPoint: nil, icon: thumbnailImage)
        }
    }
    
    // MARK: - Full Custom Menu Creation
    
    open class func showCustomMenu(title: NSAttributedString, subTitle: NSAttributedString? = nil, configuration: StyledMenuPopoverConfiguration = StyledMenuPopoverConfiguration(), items: [FlexCollectionItem], icon: UIImage? = nil, preferredSize: CGSize = CGSize(width: 200, height: 200), inFrame frame: CGRect = UIScreen.main.bounds) {
        DispatchQueue.main.async {
            let menu = StyledMenuPopover(frame: frame, configuration: configuration)
            menu.preferredSize = preferredSize
            for mi in items {
                menu.addMenuItem(mi)
            }
            menu.show(title: title, subTitle: subTitle, icon: icon)
        }
    }
    
    // MARK: - Helper for Buttons

    open class func defaultConvenienceMenuConfiguration() -> StyledMenuPopoverConfiguration {
        let mc = StyledMenuPopoverConfiguration()
        mc.menuItemSize = CGSize(width: 200, height: 40)
        mc.displayType = .normal
        mc.showTitleInHeader = false
        mc.headerStyleColor = .clear
        mc.styleColor = .white
        mc.closeButtonTextColor = .white
        mc.headerIconBorderColor = .white
        mc.closeButtonEnabled = false
        mc.headerIconBackgroundColor = .lightGray
        mc.headerIconTintColor = .black
        mc.headerIconSize = CGSize(width: 56, height: 56)
        return mc
    }
    
    // MARK: - Helper for Buttons
    
    open class func addStandardButton(popover: StyledMenuPopover, text: String, configuration: StyledMenuPopoverConfiguration, tapHandler: (() -> Void)? = nil) {
        let abt = NSAttributedString(font: configuration.menuItemFont, color: configuration.menuItemTextColor, text: text)
        let button = FlexBaseCollectionItem(reference: UUID().uuidString, text: abt)
        button.itemSelectionActionHandler = {
            if tapHandler != nil {
                tapHandler?()
            }
            popover.hide()
        }
        popover.addMenuItem(button)
    }
    
    open class func addStandardCancelButton(popover: StyledMenuPopover, configuration: StyledMenuPopoverConfiguration, tapHandler: (() -> Void)? = nil) {
        let abt = NSAttributedString(font: configuration.closeButtonFont, color: configuration.closeButtonTextColor, text: "Cancel")
        let closeButton = FlexBaseCollectionItem(reference: UUID().uuidString, text: abt)
        closeButton.itemSelectionActionHandler = {
            if tapHandler != nil {
                tapHandler?()
            }
            popover.hide()
        }
        popover.addMenuItem(closeButton)
    }
}
