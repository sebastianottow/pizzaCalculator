//
//  YeastTypeModel.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 07.08.23.
//

import RealmSwift
import UIKit


class YeastTypeModel: Object, Codable {

    @Persisted var yeastType: String
    @Persisted var amountOfYeast: Double

}
