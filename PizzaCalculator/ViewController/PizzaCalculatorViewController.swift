//
//  PizzaCalculatorViewController.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 31.07.23.
//

import RealmSwift
import UIKit


class PizzaCalculatorViewController: UIViewController {

    private let _pizzaStyleList = try! Realm().objects(PizzaStyleModel.self).sorted(byKeyPath: "pizzaStyle", ascending: true)

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

    private var _typeOfYeastTitle = UILabel()
    private var _typeOfYeastPicker = CustomDropDown()

    private var _amountOfWaterTitle = UILabel()
    private var _amountOfWaterTextfield = CustomTextField(fieldType: .inputField)

    private var _calculatePizzaDoughButton: UIButton = {
        let button = UIButton()

        button.setTitle("calculate", for: .normal)
        button.tintColor = .systemTeal
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.backgroundColor = .red

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        view.addSubview(_holderStackView)
        _holderStackView.edgesToSuperview(excluding: .bottom, insets: .init(top: 150, left: 10, bottom: 0, right: 10))

        _holderStackView.addArrangedSubview(_pizzaStylePickerTitle)
        _pizzaStylePickerTitle.text = "Pizza Style"
        _holderStackView.addArrangedSubview(_pizzaStylePicker)
        _pizzaStylePicker.height(55)
        _pizzaStylePicker.placeholder = "Pick a Style"
        _pizzaStylePicker.selectionList = _pizzaStyleList.map { $0.pizzaStyle }

        _holderStackView.addArrangedSubview(_numberOfPizzasTitle)
        _numberOfPizzasTitle.text = "Number of Pizzas"
        _holderStackView.addArrangedSubview(_numberOfPizzasTextfield)
        _numberOfPizzasTextfield.height(55)
        _numberOfPizzasTextfield.placeholder = "4"

        _holderStackView.addArrangedSubview(_sizeOfPizzasTitle)
        _sizeOfPizzasTitle.text = "Size of Pizza (gr)"
        _holderStackView.addArrangedSubview(_sizeOfPizzasTextfield)
        _sizeOfPizzasTextfield.height(55)
        _sizeOfPizzasTextfield.placeholder = "230"

        _holderStackView.addArrangedSubview(_typeOfYeastTitle)
        _typeOfYeastTitle.text = "Type of Yeast"
        _holderStackView.addArrangedSubview(_typeOfYeastPicker)
        _typeOfYeastPicker.height(55)
        _typeOfYeastPicker.placeholder = "Pick a Type"

        _holderStackView.addArrangedSubview(_amountOfWaterTitle)
        _amountOfWaterTitle.text = "Amount of water (%)"
        _holderStackView.addArrangedSubview(_amountOfWaterTextfield)
        _amountOfWaterTextfield.height(55)
        _amountOfWaterTextfield.placeholder = "65"

        _holderStackView.addArrangedSubview(_calculatePizzaDoughButton)
        _calculatePizzaDoughButton.addTarget(self, action: #selector(calculatePizzaDough), for: .touchUpInside)
    }

    @objc func calculatePizzaDough() {
        print("yeah!")
    }
}
