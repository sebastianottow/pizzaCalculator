//
//  PizzaCalculatorViewModel.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 09.08.23.
//

import Combine
import UIKit


class PizzaCalculatorViewModel {

    var pizzaTypeList = [PizzaStyleModel]()
    var yeastTypeList = [YeastTypeModel]()

    @Published var numberOfPizzas: Float = 4.0

    func createInitialPizzaTypeList() {
        
        let napolitanPizza = PizzaStyleModel(
            pizzaStyle: .napolitan,
            amountOfFlour: 137.0,
            amountOfWater: 89.0,
            amountOfSalt: 4.1,
            amountOfOil: nil,
            amountOfSugar: nil,
            amountOfPsyllium: nil
        )
        
        pizzaTypeList.append(napolitanPizza)
        
        let newYorkPizza = PizzaStyleModel(
            pizzaStyle: .newYork,
            amountOfFlour: 142.0,
            amountOfWater: 88.0,
            amountOfSalt: 4.1,
            amountOfOil: 4.3,
            amountOfSugar: 1.4,
            amountOfPsyllium: nil
        )
        
        pizzaTypeList.append(newYorkPizza)
        
        let canottoPizza = PizzaStyleModel(
            pizzaStyle: .canotto,
            amountOfFlour: 144.0,
            amountOfWater: 101.0,
            amountOfSalt: 4.3,
            amountOfOil: nil,
            amountOfSugar: nil,
            amountOfPsyllium: nil
        )
        
        pizzaTypeList.append(canottoPizza)
        
        let tondaRomanaPizza = PizzaStyleModel(
            pizzaStyle: .tondaRomana,
            amountOfFlour: 104.0,
            amountOfWater: 62.0,
            amountOfSalt: 2.6,
            amountOfOil: 6.2,
            amountOfSugar: nil,
            amountOfPsyllium: nil
        )
        
        pizzaTypeList.append(tondaRomanaPizza)
        
        let glutenFreePizza = PizzaStyleModel(
            pizzaStyle: .glutenFree,
            amountOfFlour: 166.0,
            amountOfWater: 124.0,
            amountOfSalt: 5.0,
            amountOfOil: 3.3,
            amountOfSugar: nil,
            amountOfPsyllium: 3.3
        )
        
        pizzaTypeList.append(glutenFreePizza)
    }
    
    func createInitialYeastTypeList() {
        
        let dryYeast = YeastTypeModel(
            yeastType: .dryYeast,
            amountOfYeast: 0.1
        )
        
        yeastTypeList.append(dryYeast)
        
        let freshYeast = YeastTypeModel(
            yeastType: .freshYeast,
            amountOfYeast: 0.1
        )
        
        yeastTypeList.append(freshYeast)
        
        let sourDough = YeastTypeModel(
            yeastType: .sourDough,
            amountOfYeast: 0.1
        )
        
        yeastTypeList.append(sourDough)
    }
}
