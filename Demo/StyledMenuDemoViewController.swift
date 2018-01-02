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
    }
    
    @IBAction func showSimpleMenu(_ sender: Any) {
        StyledMenuPopoverFactory.showSimpleMenu(title: NSAttributedString(string: "Title"), items: self.demoSimpleItems)
    }

}
