//
//  StyledMenuDemoViewController.swift
//  Demo
//
//  Created by Martin Rehder on 02.01.2018.
//  Copyright © 2018 Martin Jacob Rehder. All rights reserved.
//

import UIKit
import StyledOverlay
import MJRFlexStyleComponents

class StyledMenuDemoViewController: UIViewController {
    var demoSimpleItems: [FlexCollectionItem] = []
    var demoIconItems: [FlexCollectionItem] = []
    var demoInputItems: [FlexCollectionItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createDemoMenuItems()
    }

    func createDemoMenuItems() {
        for i: Int in 1...3 {
            let item = FlexBaseCollectionItem(reference: "item\(i)", text: NSAttributedString(string: "Item \(i)"))
            item.itemSelectionActionHandler = {
                NSLog("Item \(i) pressed.")
            }
            self.demoSimpleItems.append(item)
        }

        for i: Int in 1...9 {
            let icitem = FlexBaseCollectionItem(reference: "item\(i)", icon: UIImage(named: "testIcon\((i-1)%3+1)"))
            icitem.subTitle = NSAttributedString(string: "Item \(i)")
            icitem.itemSelectionActionHandler = {
                NSLog("Item \(i) pressed.")
            }
            self.demoIconItems.append(icitem)
        }

        let imenu = FlexTextFieldCollectionItem(reference: "textInput", text: NSAttributedString(string: ""))
        imenu.placeholderText = NSAttributedString(string: "Text")
        imenu.textFieldShouldReturn = {
            _ in
            return true
        }
        imenu.textIsMutable = true
        self.demoInputItems.append(imenu)
    }
    
    @IBAction func showSimpleMenu(_ sender: Any) {
        StyledMenuPopoverFactory.showSimpleMenu(title: "Simple Menu", subTitle: "Select any of the following options (Demo only)\nNew line just before!", items: self.demoSimpleItems)
    }

    @IBAction func showMenuWithIcon(_ sender: Any) {
        StyledMenuPopoverFactory.showMenuWithIcon(title: "Menu With Icon", subTitle: "Select any of the following options (Demo only)\nNew line just before!", items: self.demoSimpleItems, icon: UIImage(named: "popMenuImage1")!)
    }
    
    @IBAction func showMenuWithoutDetail(_ sender: Any) {
        StyledMenuPopoverFactory.showSimpleMenu(title: "No Details", items: self.demoSimpleItems)
    }
    
    @IBAction func showIconMenu(_ sender: Any) {
        StyledMenuPopoverFactory.showIconMenu(title: "Icon", items: self.demoIconItems, preferredSize: CGSize(width: 250, height: 200))
    }
    
    @IBAction func showInputMenu(_ sender: Any) {
        StyledMenuPopoverFactory.showSimpleMenu(title: "Input Text", subTitle: "Enter some text below", items: self.demoInputItems)
    }
    
    @IBAction func showMenuWithoutHeader(_ sender: Any) {
        let conf = StyledMenuPopoverConfiguration()
        conf.showHeader = false
        conf.menuItemSize = CGSize(width: 200, height: 40)
        conf.displayType = .normal
        conf.showTitleInHeader = false
        StyledMenuPopoverFactory.showCustomMenu(title: "No Header", configuration: conf, items: self.demoSimpleItems)
    }
    
    @IBAction func showMenuWithIconsAndWithoutHeader(_ sender: Any) {
        let conf = StyledMenuPopoverConfiguration()
        conf.showHeader = false
        conf.menuItemSize = CGSize(width: 200, height: 40)
        conf.displayType = .normal
        conf.showTitleInHeader = false
        StyledMenuPopoverFactory.showCustomMenu(title: "With Icon, No Header", configuration: conf, items: self.demoSimpleItems, icon: UIImage(named: "popMenuImage1")!)
    }

    @IBAction func showMenuWithLargeIcon(_ sender: Any) {
        let conf = StyledMenuPopoverConfiguration()
        conf.showHeader = false
        conf.menuItemSize = CGSize(width: 200, height: 40)
        conf.displayType = .normal
        conf.showTitleInHeader = false
        conf.headerIconSize = CGSize(width: 64, height: 64)
        StyledMenuPopoverFactory.showCustomMenu(title: "With Large Icon", configuration: conf, items: self.demoSimpleItems, icon: UIImage(named: "popMenuImage1")!)
    }
    @IBAction func confirmMenu(_ sender: Any) {
        StyledMenuPopoverFactory.confirmation(title: "Confirm", subTitle: "Please confirm this", buttonText: "Confirm") { confirmed in
            if confirmed {
                NSLog("You confirmed!")
            }
            else {
                NSLog("You did not confirm!")
            }
        }
    }
}
