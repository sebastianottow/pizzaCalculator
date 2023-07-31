//
//  PizzaCalculatorViewController.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 31.07.23.
//

import Foundation
import UIKit


class PizzaCalculatorViewController: UIViewController {

    private var _holderStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.distribution = .fill

        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private var _pizzaStylePickerTitle = UILabel()
    private var _pizzaStylePicker = CustomDropDown()

    private var _numberOfPizzasTitle = UILabel()
    private var _numberOfPizzasTextfield = CustomTextField(fieldType: .inputField)

    private var _sizeOfPizzasTitle = UILabel()
    private var _sizeOfPizzasTextfield = CustomTextField(fieldType: .inputField)

    private var _amountOfWaterTitle = UILabel()
    private var _amountOfWaterTextfield = CustomTextField(fieldType: .inputField)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        view.addSubview(_holderStackView)
        _holderStackView.edgesToSuperview(insets: .init(top: 150, left: 0, bottom: 85, right: 0))

        _holderStackView.addArrangedSubview(_pizzaStylePickerTitle)
        _pizzaStylePickerTitle.text = "Pizza Style"
        _holderStackView.addArrangedSubview(_pizzaStylePicker)
        _pizzaStylePicker.placeholder = "Pick a Style"

        _holderStackView.addArrangedSubview(_numberOfPizzasTitle)
        _numberOfPizzasTitle.text = "Number of Pizzas"
        _holderStackView.addArrangedSubview(_numberOfPizzasTextfield)
        _numberOfPizzasTextfield.placeholder = "4"

        _holderStackView.addArrangedSubview(_sizeOfPizzasTitle)
        _sizeOfPizzasTitle.text = "Size of Pizza (gr)"
        _holderStackView.addArrangedSubview(_sizeOfPizzasTextfield)
        _sizeOfPizzasTextfield.placeholder = "230"

        _holderStackView.addArrangedSubview(_amountOfWaterTitle)
        _amountOfWaterTitle.text = "Amount of water (%)"
        _holderStackView.addArrangedSubview(_amountOfWaterTextfield)
        _amountOfWaterTextfield.placeholder = "65"
    }
}
