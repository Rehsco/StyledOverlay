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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createDemoMenuItems()
    }

    func createDemoMenuItems() {
        let item1 = FlexBaseCollectionItem(reference: "item1", text: NSAttributedString(string: "item1"), icon: nil, accessoryImage: nil, title: nil, accessoryImageActionHandler: nil)
        item1.itemSelectionActionHandler = {
            NSLog("Item 1 pressed.")
        }
        self.demoSimpleItems.append(item1)
        let item2 = FlexBaseCollectionItem(reference: "item2", text: NSAttributedString(string: "item2"), icon: nil, accessoryImage: nil, title: nil, accessoryImageActionHandler: nil)
        item2.itemSelectionActionHandler = {
            NSLog("Item 2 pressed.")
        }
        self.demoSimpleItems.append(item2)
        let item3 = FlexBaseCollectionItem(reference: "item3", text: NSAttributedString(string: "item3"), icon: nil, accessoryImage: nil, title: nil, accessoryImageActionHandler: nil)
        item3.itemSelectionActionHandler = {
            NSLog("Item 3 pressed.")
        }
        self.demoSimpleItems.append(item3)
    }
    
    @IBAction func showSimpleMenu(_ sender: Any) {
        StyledMenuPopoverFactory.showSimpleMenu(title: NSAttributedString(string: "Title"), subTitle: NSAttributedString(string: "Select any of the following options (Demo only)\nNew line just before!"), items: self.demoSimpleItems)
    }

    @IBAction func showMenuWithIcon(_ sender: Any) {
        StyledMenuPopoverFactory.showMenuWithIcon(title: NSAttributedString(string: "Title"), subTitle: NSAttributedString(string: "Select any of the following options (Demo only)\nNew line just before!"), items: self.demoSimpleItems, icon: UIImage(named: "popMenuImage1")!)
    }
    
    @IBAction func showMenuWithoutDetail(_ sender: Any) {
        StyledMenuPopoverFactory.showSimpleMenu(title: NSAttributedString(string: "Title"), items: self.demoSimpleItems)
    }
}
