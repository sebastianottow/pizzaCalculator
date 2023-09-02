//
//  PizzaCalculatorViewModel.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 09.08.23.
//

import Combine
import UIKit


class PizzaCalculatorViewModel {

    var pizzaStyleOptions = PizzaReceipeModel.TypeOfPizza.allCases
    var yeastTypeOptions = YeastTypeModel.allCases

    @Published var selectedPizzaStyleOption: PizzaReceipeModel.TypeOfPizza = .napolitan
    @Published var selectedYeastTypeOption: YeastTypeModel = .dryYeast
    @Published var selectedNumberOfPizza: Float = 4.0
    @Published var selectedSizeOfPizza: Float = 230.0
    @Published var selectedPercentageOfWater: Float = 65.0

    func calculatePizzaIngredients(
        selectedPizzaOption: PizzaReceipeModel.TypeOfPizza,
        selectedYeastOption: YeastTypeModel,
        selectedNumberOfPizza: Int,
        selectedSizeOfPizza: Int,
        selectedPercentageOfWater: Int

    ) {
        print("calculate pizza ingredients")
    }
}
