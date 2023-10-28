//
//  ReceipeViewController.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 04.09.23.
//

import Combine
import UIKit


class ReceipeViewController: UIViewController {
    
    private var _pizzaCalculatorViewModel = PizzaCalculatorViewModel()
    
    private var _cancellables = Set<AnyCancellable>()

    private let _handMadeLabel = UILabel()
    private let _thermomixLabel = UILabel()
    
    private let _receipeView = ReceipeView()

    private let _holderStackView: UIStackView = {
        let stack = UIStackView()

        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.spacing = 10

        return stack
    }()
    
    let label = UILabel()

    private let _doughMixingSwitch = UISwitch()

    init(viewModel: PizzaCalculatorViewModel) {
        self._pizzaCalculatorViewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(_holderStackView)
        _holderStackView.edgesToSuperview(excluding: .bottom, insets: .init(top: 0, left: 10, bottom: 0, right: 10))
        
        _holderStackView.addArrangedSubview(_receipeView)
        _receipeView.edgesToSuperview(excluding: [.left, .bottom, .right], insets: .init(top: 100, left: 0, bottom: 0, right: 0))
        
        _receipeView.selectedPizzaStyleTitle.text = "For your \(_pizzaCalculatorViewModel.selectedPizzaStyleOption) style pizza you need to mix the following amount of ingredients:"
        
        _receipeView.amountOfFlourRequired.text = "\(_pizzaCalculatorViewModel.calculatedAmountOfFlour) g of flour"
        
        _receipeView.amountOfWaterRequired.text = "\(_pizzaCalculatorViewModel.calculatedAmountOfWater) g of water"
        
        _receipeView.amountOfSaltRequired.text = "\(_pizzaCalculatorViewModel.calculatedAmountOfSalt) g salt"
        
        _receipeView.amountOfYeastRequired.text = "\(_pizzaCalculatorViewModel.calculatedAmountOfYeast) g of \(_pizzaCalculatorViewModel.selectedYeastTypeOption)"

    }
}
