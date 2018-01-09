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
        let item1 = FlexBaseCollectionItem(reference: "item1", text: NSAttributedString(string: "Item 1"))
        item1.itemSelectionActionHandler = {
            NSLog("Item 1 pressed.")
        }
        self.demoSimpleItems.append(item1)
        let item2 = FlexBaseCollectionItem(reference: "item2", text: NSAttributedString(string: "Item 2"))
        item2.itemSelectionActionHandler = {
            NSLog("Item 2 pressed.")
        }
        self.demoSimpleItems.append(item2)
        let item3 = FlexBaseCollectionItem(reference: "item3", text: NSAttributedString(string: "Item 3"))
        item3.itemSelectionActionHandler = {
            NSLog("Item 3 pressed.")
        }
        self.demoSimpleItems.append(item3)
        
        let icitem1 = FlexBaseCollectionItem(reference: "item1", icon: UIImage(named: "testIcon1"))
        icitem1.subTitle = NSAttributedString(string: "Item 1")
        icitem1.itemSelectionActionHandler = {
            NSLog("Item 1 pressed.")
        }
        self.demoIconItems.append(icitem1)
        let icitem2 = FlexBaseCollectionItem(reference: "item2", icon: UIImage(named: "testIcon2"))
        icitem2.subTitle = NSAttributedString(string: "Item 2")
        icitem2.itemSelectionActionHandler = {
            NSLog("Item 2 pressed.")
        }
        self.demoIconItems.append(icitem2)
        let icitem3 = FlexBaseCollectionItem(reference: "item3", icon: UIImage(named: "testIcon3"))
        icitem3.subTitle = NSAttributedString(string: "Item 3")
        icitem3.itemSelectionActionHandler = {
            NSLog("Item 3 pressed.")
        }
        self.demoIconItems.append(icitem3)

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
        StyledMenuPopoverFactory.showSimpleMenu(title: NSAttributedString(string: "Simple Menu"), subTitle: NSAttributedString(string: "Select any of the following options (Demo only)\nNew line just before!"), items: self.demoSimpleItems)
    }

    @IBAction func showMenuWithIcon(_ sender: Any) {
        StyledMenuPopoverFactory.showMenuWithIcon(title: NSAttributedString(string: "Menu With Icon"), subTitle: NSAttributedString(string: "Select any of the following options (Demo only)\nNew line just before!"), items: self.demoSimpleItems, icon: UIImage(named: "popMenuImage1")!)
    }
    
    @IBAction func showMenuWithoutDetail(_ sender: Any) {
        StyledMenuPopoverFactory.showSimpleMenu(title: NSAttributedString(string: "No Details"), items: self.demoSimpleItems)
    }
    
    @IBAction func showIconMenu(_ sender: Any) {
        StyledMenuPopoverFactory.showIconMenu(title: NSAttributedString(string: "Icon"), items: self.demoIconItems, preferredSize: CGSize(width: 320, height: 200))
    }
    
    @IBAction func showInputMenu(_ sender: Any) {
        StyledMenuPopoverFactory.showSimpleMenu(title: NSAttributedString(string: "Input Text"), subTitle: NSAttributedString(string: "Enter some text below"), items: self.demoInputItems)
    }
    
    @IBAction func showMenuWithoutHeader(_ sender: Any) {
        let conf = StyledMenuPopoverConfiguration()
        conf.showHeader = false
        conf.menuItemSize = CGSize(width: 200, height: 40)
        conf.displayType = .normal
        conf.showTitleInHeader = false
        StyledMenuPopoverFactory.showCustomMenu(title: NSAttributedString(string: "No Header"), configuration: conf, items: self.demoSimpleItems)
    }
    
    @IBAction func showMenuWithIconsAndWithoutHeader(_ sender: Any) {
        let conf = StyledMenuPopoverConfiguration()
        conf.showHeader = false
        conf.menuItemSize = CGSize(width: 200, height: 40)
        conf.displayType = .normal
        conf.showTitleInHeader = false
        StyledMenuPopoverFactory.showCustomMenu(title: NSAttributedString(string: "With Icon, No Header"), configuration: conf, items: self.demoSimpleItems, icon: UIImage(named: "popMenuImage1")!)
    }
}
