//
//  UIImageExtension.swift
//  StyledOverlay
//
//  Created by Martin Rehder on 22.10.2016.
//  Copyright © 2016 Martin Jacob Rehder. All rights reserved.
//

import UIKit

extension UIImage {
    func tint(_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.translateBy(x: 0, y: self.size.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        ctx.setBlendMode(CGBlendMode.normal)
        
        let area = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        ctx.clip(to: area, mask: self.cgImage!)
        ctx.fill(area)
        
        defer { UIGraphicsEndImageContext() }
        
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}
