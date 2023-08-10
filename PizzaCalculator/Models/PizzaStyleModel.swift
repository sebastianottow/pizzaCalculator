//
//  PizzaStyleModel.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 07.08.23.
//

import UIKit
import RealmSwift


class PizzaStyleModel {
    
    enum TypeOfPizza: String {
        case napolitan = "Napolitan"
        case newYork = "New York"
        case canotto = "Canotto"
        case tondaRomana = "Tonda Romana"
        case glutenFree = "Gluten Free"
    }

    var pizzaStyle: TypeOfPizza
    var amountOfFlour: Double
    var amountOfWater: Double
    var amountOfSalt: Double
    var amountOfOil: Double?
    var amountOfSugar: Double?
    var amountOfPsyllium: Double?
    
    init(pizzaStyle: TypeOfPizza, amountOfFlour: Double, amountOfWater: Double, amountOfSalt: Double, amountOfOil: Double?, amountOfSugar: Double?, amountOfPsyllium: Double?) {
        
        self.pizzaStyle = pizzaStyle
        self.amountOfFlour = amountOfFlour
        self.amountOfWater = amountOfWater
        self.amountOfSalt = amountOfSalt
        self.amountOfOil = amountOfOil
        self.amountOfSugar = amountOfSugar
        self.amountOfPsyllium = amountOfPsyllium
        
    }

}
