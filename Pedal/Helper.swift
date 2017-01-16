//
//  Helper.swift
//  UITestProject
//
//  Created by Nabil K on 2016-12-10.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    static func toPicture(data: Data) -> UIImage?{
        return UIImage(data: data)
    }
    
    static func toData(image:UIImage) -> Data?{
        return UIImagePNGRepresentation(image)
    }
    
   static func imageRotatedByDegrees(oldImage: UIImage, deg degrees: CGFloat) -> UIImage {
        //Calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: oldImage.size.width, height: oldImage.size.height))
        let t: CGAffineTransform = CGAffineTransform(rotationAngle: degrees * CGFloat(M_PI / 180))
        rotatedViewBox.transform = t
        let rotatedSize: CGSize = rotatedViewBox.frame.size
        //Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        //Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        //Rotate the image context
        bitmap.rotate(by: (degrees * CGFloat(M_PI / 180)))
        //Now, draw the rotated/scaled image into the context
        bitmap.scaleBy(x: 1.0, y: -1.0)
        bitmap.draw(oldImage.cgImage!, in: CGRect(x: -oldImage.size.width / 2, y: -oldImage.size.height / 2, width: oldImage.size.width, height: oldImage.size.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}


extension UIImage{
    
    
    func toData() -> Data?{
        return UIImageJPEGRepresentation(self, 0.93)
//        return UIImagePNGRepresentation(self)
    }
}

extension Data{
   
    func toPicture() -> UIImage?{
        return UIImage(data: self)
    }

    
}
