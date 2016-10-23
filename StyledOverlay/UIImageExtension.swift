//
//  UIImageExtension.swift
//  StyledOverlay
//
//  Created by Martin Rehder on 22.10.2016.
//  Copyright © 2016 Martin Jacob Rehder. All rights reserved.
//

import UIKit

extension UIImage {
    public func tint(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        
        let ctx = UIGraphicsGetCurrentContext()!
        CGContextTranslateCTM(ctx, 0, self.size.height)
        CGContextScaleCTM(ctx, 1.0, -1.0)
        CGContextSetBlendMode(ctx, CGBlendMode.Normal)
        
        let area = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        CGContextClipToMask(ctx, area, self.CGImage!)
        CGContextFillRect(ctx, area)
        
        defer { UIGraphicsEndImageContext() }
        
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}
