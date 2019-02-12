//
//  StyledMenuCustomPopoverBuilder.swift
//  SafeCompanionPro
//
//  Created by Martin Rehder on 08.02.2019.
//  Copyright © 2019 Martin Jacob Rehder. All rights reserved.
//

import UIKit
import MJRFlexStyleComponents

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
    
    public func addButton(text: String, tapHandler: (() -> Void)? = nil) -> StyledMenuCustomPopoverBuilder {
        StyledMenuPopoverFactory.addStandardButton(popover: popover, text: text, configuration: configuration, tapHandler: tapHandler)
        return self
    }

    public func addStandardCancelButton(tapHandler: (() -> Void)? = nil) -> StyledMenuCustomPopoverBuilder {
        StyledMenuPopoverFactory.addStandardCancelButton(popover: popover, configuration: configuration, tapHandler: tapHandler)
        return self
    }
    
    public func show(title: NSAttributedString, subTitle: NSAttributedString?, topLeftPoint: CGPoint? = nil, icon: UIImage? = nil) -> StyledMenuCustomPopoverBuilder {
        popover.show(title: title, subTitle: subTitle, topLeftPoint: topLeftPoint, icon: icon)
        return self
    }

    @discardableResult
    public func show(title: String, subTitle: String?, topLeftPoint: CGPoint? = nil, icon: UIImage? = nil) -> StyledMenuCustomPopoverBuilder {
        let atitle = NSAttributedString(font: configuration.headerFont, color: configuration.headerTextColor, text: title)
        var asubtitle: NSAttributedString? = nil
        if let st = subTitle {
            asubtitle = NSAttributedString(font: configuration.menuSubtitleFont, color: configuration.menuSubtitleTextColor, text: st)
        }
        popover.show(title: atitle, subTitle: asubtitle, topLeftPoint: topLeftPoint, icon: icon)
        return self
    }

    @discardableResult
    public func hide() -> StyledMenuCustomPopoverBuilder {
        popover.hide()
        return self
    }
    
}