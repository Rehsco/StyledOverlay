//
//  ViewController.swift
//  Demo
//
//  Created by Martin Rehder on 22.10.2016.
//  Copyright © 2016 Martin Jacob Rehder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var simpleOverlay: StyledLabelsOverlay!

    @IBOutlet weak var downloadActionOverlay: StyledActionOverlay!
    @IBOutlet weak var playActionOverlay: StyledActionOverlay!
    @IBOutlet weak var encryptionActionOverlay: StyledActionOverlay!
    @IBOutlet weak var progressActionOverlay: StyledActionOverlay!
    @IBOutlet weak var busyLoopActionOverlay: StyledActionOverlay!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initOverlays()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    func initOverlays() {
        self.initDefaultOverlay(self.simpleOverlay)
        
        simpleOverlay.upperLabel.attributedText = NSAttributedString(string: "Upper Label")
        simpleOverlay.centerLabel.attributedText = NSAttributedString(string: "Center Label")
        simpleOverlay.lowerLabel.attributedText = NSAttributedString(string: "Lower Label")
        
        simpleOverlay.upperLabel.textColor = .whiteColor()
        simpleOverlay.centerLabel.textColor = .whiteColor()
        simpleOverlay.lowerLabel.textColor = .whiteColor()
        
        self.initDefaultOverlay(self.downloadActionOverlay)
        self.downloadActionOverlay.actionType = .Download
        self.initDefaultOverlay(self.playActionOverlay)
        self.playActionOverlay.actionType = .Play
        self.initDefaultOverlay(self.encryptionActionOverlay)
        self.encryptionActionOverlay.actionType = .Encrypted
        self.initDefaultOverlay(self.progressActionOverlay)
        self.progressActionOverlay.actionType = .ProgressRing(progress: 0.42)
        self.progressActionOverlay.indicatorLineWidth = 3
        self.initDefaultOverlay(self.busyLoopActionOverlay)
        self.busyLoopActionOverlay.actionType = .BusyLoop
    }
    
    func initDefaultOverlay(over: StyledBaseOverlay) {
        over.style = .RoundedFixed(cornerRadius: 5)
        over.styleColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    }
}

