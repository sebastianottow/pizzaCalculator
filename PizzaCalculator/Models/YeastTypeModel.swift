//
//  YeastTypeModel.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 07.08.23.
//

import UIKit


class YeastTypeModel {
    
    enum YeastType: String {
    case dryYeast = "Dry Yeast"
    case freshYeast = "Fresh Yeast"
    case sourDough = "Sourdough"
    }

    var yeastType: YeastType
    var amountOfYeast: Double = 0.1
    
    init(yeastType: YeastType, amountOfYeast: Double) {
        self.yeastType = yeastType
        self.amountOfYeast = amountOfYeast
    }
}
