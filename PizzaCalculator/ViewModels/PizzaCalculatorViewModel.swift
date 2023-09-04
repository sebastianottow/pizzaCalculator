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

    private var _cancellables = Set<AnyCancellable>()

    @Published var selectedPizzaStyleOption: PizzaReceipeModel.TypeOfPizza = .napolitan
    @Published var selectedYeastTypeOption: YeastTypeModel = .dryYeast
    @Published var selectedNumberOfPizza: Float = 4.0
    @Published var selectedSizeOfPizza: Float = 230.0
    @Published var selectedPercentageOfWater: Float = 65.0

    //MARK: list of ingredients and amounts calculated
    @Published var calculatedAmountOfFlour: Double = 0.0
    @Published var calculatedAmountOfWater: Double = 0.0
    @Published var calculatedAmountOfSalt: Double = 0.0
    @Published var calculatedAmountOfYeast: Double = 0.0
    @Published var calculatedAmountOfOil: Double = 0.0
    @Published var calculatedAmountOfSugar: Double = 0.0
    @Published var calculatedAmountOfPsyllium: Double = 0.0

    func calculatePizzaIngredients(
        selectedPizzaOption: PizzaReceipeModel.TypeOfPizza,
        selectedYeastOption: YeastTypeModel,
        selectedNumberOfPizza: Double,
        selectedSizeOfPizza: Double,
        selectedPercentageOfWater: Double

    ) {
        let yeastFactor: Double = {

            switch selectedYeastOption {
            case .dryYeast: return selectedPizzaOption.amountOfDryYeast
            case .freshYeast: return selectedPizzaOption.amountOfFreshYeast
            case .sourdough: return selectedPizzaOption.amountOfSourdough
            }
            
        }()

        calculatedAmountOfFlour = selectedNumberOfPizza * selectedPizzaOption.amountOfFlour
        calculatedAmountOfWater = calculatedAmountOfFlour * (selectedPercentageOfWater / 100)
        calculatedAmountOfSalt = selectedNumberOfPizza * selectedPizzaOption.amountOfSalt
        calculatedAmountOfYeast = yeastFactor * selectedNumberOfPizza
        calculatedAmountOfOil = selectedNumberOfPizza * selectedPizzaOption.amountofOil
        calculatedAmountOfSugar = selectedNumberOfPizza * selectedPizzaOption.amountOfSugar
        calculatedAmountOfPsyllium = selectedNumberOfPizza * selectedPizzaOption.amountOfPsyllium
    }
}
