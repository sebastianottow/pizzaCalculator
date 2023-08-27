//
//  UIImageCustomExtension.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 25.08.23.
//

import UIKit


extension UIImage {

    func scale(setWidth: CGFloat) -> UIImage {

        guard self.size.width != setWidth else { return self }

        let scaleFactor = setWidth / self.size.width

        let setHeight = self.size.height * scaleFactor
        let newSize = CGSize(width: setWidth, height: setHeight)

        UIGraphicsBeginImageContextWithOptions(newSize, true, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: setWidth, height: setHeight))

        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        return newImage ?? self
    }
}
