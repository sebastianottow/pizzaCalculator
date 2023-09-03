//
//  PizzaReceipeModel.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 07.08.23.
//

import UIKit
import RealmSwift


class PizzaReceipeModel {

    enum TypeOfPizza: String, CaseIterable, Codable {
        case napolitan = "Napolitan"
        case newYork = "New York"
        case canotto = "Canotto"
        case tondaRomana = "Tonda Romana"
        case glutenFree = "Gluten Free"

        var amountOfFlour: Double {
            switch self {
            case .napolitan: return 137.0
            case .newYork: return 143.0
            case .canotto: return 144.0
            case .tondaRomana: return 104.0
            case .glutenFree: return 166.0
            }
        }

        var amountOfWater: Double {
            switch self {
            case .napolitan: return 89.0
            case .newYork: return 88.0
            case .canotto: return 101.0
            case .tondaRomana: return 62.0
            case .glutenFree: return 124.0
            }
        }

        var amountOfSalt: Double {
            switch self {
            case .napolitan: return 4.1
            case .newYork: return 2.9
            case .canotto: return 4.3
            case .tondaRomana: return 2.6
            case .glutenFree: return 5.0
            }
        }

        var amountofOil: Double {
            switch self {
            case .newYork: return 4.3
            case .tondaRomana: return 6.2
            case .glutenFree: return 3.3
            default: return 0.0
            }
        }

        var amountOfSugar: Double {
            switch self {
            case .newYork: return 1.4
            default: return 0.0
            }
        }

        var amountOfPsyllium: Double {
            switch self {
            case .glutenFree: return 3.3
            default: return 0.0
            }
        }

        var amountOfDryYeast: Double {
            switch self {
            case .napolitan: return 0.1
            case .newYork: return 0.4
            case .canotto: return 0.2
            case .tondaRomana: return 0.1
            case .glutenFree: return 0.5
            }
        }

        var amountOfFreshYeast: Double {
            switch self {
            case .napolitan: return 0.3
            case .newYork: return 1.1
            case .canotto: return 0.6
            case .tondaRomana: return 0.2
            case .glutenFree: return 1.5
            }
        }

        var amountOfSourdough: Double {
            switch self {
            case .napolitan: return 27.0
            case .newYork: return 28.0
            case .canotto: return 29.0
            case .tondaRomana: return 21.0
            case .glutenFree: return 33.0
            }
        }

        var defaultPizzaSize: Double {
            switch self {
            case .napolitan: return 230.0
            case .newYork: return 240.0
            case .canotto: return 250.0
            case .tondaRomana: return 175.0
            case .glutenFree: return 300.0
            }
        }
        
        var defaultPercentageOfWater: Double {
            switch self {
            case .napolitan: return 65.0
            case .newYork: return 62.0
            case .canotto: return 70.0
            case .tondaRomana: return 60.0
            case .glutenFree: return 75.0
            }
        }
    }
}
