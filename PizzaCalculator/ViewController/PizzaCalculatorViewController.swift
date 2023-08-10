//
//  PizzaCalculatorViewController.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 31.07.23.
//

import Combine
import CombineCocoa
import RealmSwift
import UIKit


class PizzaCalculatorViewController: UIViewController {
    
    private let _viewModel = PizzaCalculatorViewModel()

    private var _cancellables = Set<AnyCancellable>()

    private var _holderStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.distribution = .fill

        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let _horizontalStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private var _pizzaStylePickerTitle = UILabel()
    private var _pizzaStylePicker = CustomDropDown()

    private var _numberOfPizzasTitle = UILabel()
    private var _numberOfPizzasSliderLabel = UILabel()
    private var _numberOfPizzasSlider: UISlider = {
        let slider = UISlider()

        slider.minimumValue = 0
        slider.maximumValue = 20
        slider.isContinuous = true
        slider.tintColor = UIColor(red: 0.91, green: 0.37, blue: 0.31, alpha: 1.00)
        slider.setValue(4, animated: true)

        return slider
    }()

    private var _sizeOfPizzasTitle = UILabel()
    private var _sizeOfPizzasPicker = CustomDropDown()

    private var _typeOfYeastTitle = UILabel()
    private var _typeOfYeastPicker = CustomDropDown()

    private var _amountOfWaterTitle = UILabel()
    private var _amountOfWaterPicker = CustomDropDown()

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

        setupPublishers()
        setupUI()
        bind(viewModel: _viewModel)
    }

    private func setupPublishers() {

        _numberOfPizzasSlider.valuePublisher
            .map { $0 }
            .assign(to: \.numberOfPizzas, on: _viewModel)
            .store(in: &_cancellables)
    }

    private func bind(viewModel: PizzaCalculatorViewModel) {

        viewModel.$numberOfPizzas
            .receive(on: DispatchQueue.main)
            .sink { [weak self] numberOfPizzasValue in

                let formatter = NumberFormatter()
                formatter.numberStyle = .none

                let number = NSNumber(value: numberOfPizzasValue)

                let formattedValue = formatter.string(from: number)

                self?._numberOfPizzasSliderLabel.text = formattedValue
            }
            .store(in: &_cancellables)
    }

    private func setupUI() {
        _viewModel.createInitialYeastTypeList()
        _viewModel.createInitialPizzaTypeList()
        
        view.addSubview(_holderStackView)
        _holderStackView.edgesToSuperview(excluding: .bottom, insets: .init(top: 150, left: 10, bottom: 0, right: 10))

        _pizzaStylePicker.createPickerView()
        _holderStackView.addArrangedSubview(_pizzaStylePickerTitle)
        _pizzaStylePickerTitle.text = "Pizza Style"
        _holderStackView.addArrangedSubview(_pizzaStylePicker)
        _pizzaStylePicker.height(55)
        _pizzaStylePicker.placeholder = "Pick a Style"
        _pizzaStylePicker.selectionList = _viewModel.pizzaTypeList.map { $0.pizzaStyle.rawValue }
        
        _typeOfYeastPicker.createPickerView()
        _holderStackView.addArrangedSubview(_typeOfYeastTitle)
        _typeOfYeastTitle.text = "Type of Yeast"
        _holderStackView.addArrangedSubview(_typeOfYeastPicker)
        _typeOfYeastPicker.height(55)
        _typeOfYeastPicker.placeholder = "Pick a Type"
        _typeOfYeastPicker.selectionList = _viewModel.yeastTypeList.map { $0.yeastType.rawValue }

        _holderStackView.addArrangedSubview(_horizontalStackView)
        _horizontalStackView.addArrangedSubview(_numberOfPizzasTitle)
        _numberOfPizzasTitle.text = "Number of Pizzas"
        _horizontalStackView.addArrangedSubview(_numberOfPizzasSliderLabel)
        _holderStackView.addArrangedSubview(_numberOfPizzasSlider)
        _numberOfPizzasSlider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)

        _sizeOfPizzasPicker.createPickerView()
        _holderStackView.addArrangedSubview(_sizeOfPizzasTitle)
        _sizeOfPizzasTitle.text = "Size of Pizza (gr)"
        _holderStackView.addArrangedSubview(_sizeOfPizzasPicker)
        _sizeOfPizzasPicker.height(55)
        _sizeOfPizzasPicker.placeholder = "230"

        _amountOfWaterPicker.createPickerView()
        _holderStackView.addArrangedSubview(_amountOfWaterTitle)
        _amountOfWaterTitle.text = "Amount of water (%)"
        _holderStackView.addArrangedSubview(_amountOfWaterPicker)
        _amountOfWaterPicker.height(55)
        _amountOfWaterPicker.placeholder = "65"

        _holderStackView.addArrangedSubview(_calculatePizzaDoughButton)
        _calculatePizzaDoughButton.addTarget(self, action: #selector(calculatePizzaDough), for: .touchUpInside)
    }

    @objc func sliderValueDidChange(_ sender: UISlider!) {
        let step: Float = 1

        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue

        _viewModel.numberOfPizzas = roundedStepValue
    }

    @objc func calculatePizzaDough() {
        print("yeah!")
    }
}
