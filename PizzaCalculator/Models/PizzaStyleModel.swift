//
//  PizzaStyleModel.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 07.08.23.
//

import UIKit
import RealmSwift


class PizzaStyleModel: Object, Codable {

    @Persisted var pizzaStyle: String
    @Persisted var amountOfFlour: Double
    @Persisted var amountOfWater: Double
    @Persisted var amountOfSalt: Double
    @Persisted var amountOfYeast: YeastTypeModel

}
