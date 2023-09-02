//
//  PizzaCalculatorViewController.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 31.07.23.
//

import Combine
import CombineCocoa
import RealmSwift
import TinyConstraints
import UIKit


class PizzaCalculatorViewController: UIViewController {

    private let _viewModel = PizzaCalculatorViewModel()

    private var _cancellables = Set<AnyCancellable>()

    private var _holderStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20

        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private var _pizzaStylePickerTitle = UILabel()
    private var _pizzaStylePicker = CustomDropDown()

    private var _numberOfPizzasTitle = UILabel()
    private var _numberOfPizzasSliderLabel = UILabel()
    private var _numberOfPizzasSlider = CustomSlider()

    private var _sizeOfPizzasTitle = UILabel()
    private var _sizeOfPizzasSliderLabel = UILabel()
    private var _sizeOfPizzasSlider = CustomSlider()

    private var _typeOfYeastTitle = UILabel()
    private var _typeOfYeastPicker = CustomDropDown()

    private var _amountOfWaterTitle = UILabel()
    private var _amountOfWaterSliderLabel = UILabel()
    private var _amountOfWaterSlider = CustomSlider()

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
        bind(viewModel: _viewModel)
        setupPublishers()
    }

    private func setupPublishers() {

        _numberOfPizzasSlider.valuePublisher
            .map { $0 }
            .assign(to: \.selectedNumberOfPizza, on: _viewModel)
            .store(in: &_cancellables)

        _sizeOfPizzasSlider.valuePublisher
            .map { $0 }
            .assign(to: \.selectedSizeOfPizza, on: _viewModel)
            .store(in: &_cancellables)

        _amountOfWaterSlider.valuePublisher
            .map { $0 }
            .assign(to: \.selectedPercentageOfWater, on: _viewModel)
            .store(in: &_cancellables)
    }

    private func bind(viewModel: PizzaCalculatorViewModel) {

        _pizzaStylePicker.$value
            .receive(on: DispatchQueue.main)
            .sink { [weak self] selectedPizzaOption in
                guard let selectedPizzaOption = selectedPizzaOption, let self = self else { return }
                self._viewModel.selectedPizzaStyleOption = self._viewModel.pizzaStyleOptions[selectedPizzaOption - 1]
            }
            .store(in: &_cancellables)

        _typeOfYeastPicker.$value
            .receive(on: DispatchQueue.main)
            .sink { [weak self] selectedYeastOption in
                guard let selectedYeastOption = selectedYeastOption, let self = self else { return }
                self._viewModel.selectedYeastTypeOption = self._viewModel.yeastTypeOptions[selectedYeastOption - 1]
            }
            .store(in: &_cancellables)

        viewModel.$selectedNumberOfPizza
            .receive(on: DispatchQueue.main)
            .sink { [weak self] selectedNumberOfPizzaValue in

                let formatter = NumberFormatter()
                formatter.numberStyle = .none

                let number = NSNumber(value: selectedNumberOfPizzaValue)

                let formattedValue = formatter.string(from: number)

                self?._numberOfPizzasSliderLabel.text = formattedValue
            }
            .store(in: &_cancellables)

        viewModel.$selectedSizeOfPizza
            .receive(on: DispatchQueue.main)
            .sink { [weak self] selectedSizeOfPizzaValue in

                let formatter = NumberFormatter()
                formatter.numberStyle = .none

                let number = NSNumber(value: selectedSizeOfPizzaValue)

                let formattedValue = formatter.string(from: number)

                self?._sizeOfPizzasSliderLabel.text = "\(formattedValue ?? "230") gr"
            }
            .store(in: &_cancellables)

        viewModel.$selectedPercentageOfWater
            .receive(on: DispatchQueue.main)
            .sink { [weak self] selectedAmountOfWaterValue in

                let formatter = NumberFormatter()
                formatter.numberStyle = .none

                let number = NSNumber(value: selectedAmountOfWaterValue)

                let formattedValue = formatter.string(from: number)

                // MARK: set default value based on pizza style!
                self?._amountOfWaterSliderLabel.text = "\(formattedValue ?? "65") %"
            }
            .store(in: &_cancellables)
    }

    private func setupUI() {
        
        view.addSubview(_holderStackView)
        _holderStackView.edgesToSuperview(excluding: .bottom, insets: .init(top: 150, left: 10, bottom: 0, right: 10))

        _pizzaStylePicker.createPickerView()
        _holderStackView.addArrangedSubview(_pizzaStylePickerTitle)
        _pizzaStylePickerTitle.text = "Pizza Style"
        _holderStackView.addArrangedSubview(_pizzaStylePicker)
        _pizzaStylePicker.height(55)
        _pizzaStylePicker.options = _viewModel.pizzaStyleOptions.map { $0.rawValue }
        
        _typeOfYeastPicker.createPickerView()
        _holderStackView.addArrangedSubview(_typeOfYeastTitle)
        _typeOfYeastTitle.text = "Type of Yeast"
        _holderStackView.addArrangedSubview(_typeOfYeastPicker)
        _typeOfYeastPicker.height(55)
        _typeOfYeastPicker.options = _viewModel.yeastTypeOptions.map { $0.rawValue }

        setupNumberOfPizzaSlider()
        setupSizeOfPizzasSlider()
        setupAmountOfWaterSlider()

        _holderStackView.addArrangedSubview(_calculatePizzaDoughButton)
        _calculatePizzaDoughButton.topToBottom(of: _amountOfWaterSlider, offset: 60)
        _calculatePizzaDoughButton.addTarget(self, action: #selector(calculatePizzaDough), for: .touchUpInside)
    }

    private func setupNumberOfPizzaSlider() {
        _numberOfPizzasSlider.createSlider()
        _numberOfPizzasSlider.sliderMinValue = 1
        _numberOfPizzasSlider.sliderMaxValue = 20
        _numberOfPizzasSlider.sliderDefaultValue = 4
        _numberOfPizzasSlider.sliderThumbIcon = UIImage(named: "iconPizzaSlider")!.scale(setWidth: 25)

        let horizontalStackView: UIStackView = {
            let stackView = UIStackView()

            stackView.axis = .horizontal
            stackView.spacing = 5
            stackView.translatesAutoresizingMaskIntoConstraints = false

            return stackView
        }()

        _holderStackView.addArrangedSubview(_numberOfPizzasTitle)
        _numberOfPizzasTitle.text = "Number of Pizzas"

        _holderStackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(_numberOfPizzasSlider)
        horizontalStackView.addArrangedSubview(_numberOfPizzasSliderLabel)
        _numberOfPizzasSliderLabel.width(60)
        _numberOfPizzasSliderLabel.textAlignment = .center
    }

    private func setupSizeOfPizzasSlider() {
        _sizeOfPizzasSlider.createSlider()
        _sizeOfPizzasSlider.sliderMinValue = 150
        _sizeOfPizzasSlider.sliderMaxValue = 1_000
        // MARK: defaultValue should be set by selection of pizza style since it differs per type!
        _sizeOfPizzasSlider.sliderDefaultValue = 230
        _sizeOfPizzasSlider.sliderThumbIcon = UIImage(systemName: "person")!

        let horizontalStackView: UIStackView = {
            let stackView = UIStackView()

            stackView.axis = .horizontal
            stackView.spacing = 5
            stackView.translatesAutoresizingMaskIntoConstraints = false

            return stackView
        }()

        _holderStackView.addArrangedSubview(_sizeOfPizzasTitle)
        _sizeOfPizzasTitle.text = "Size of Pizza"

        _holderStackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(_sizeOfPizzasSlider)
        horizontalStackView.addArrangedSubview(_sizeOfPizzasSliderLabel)
        _sizeOfPizzasSliderLabel.width(60)
        _sizeOfPizzasSliderLabel.textAlignment = .center
    }

    private func setupAmountOfWaterSlider() {
        _amountOfWaterSlider.createSlider()
        _amountOfWaterSlider.sliderMinValue = 0
        _amountOfWaterSlider.sliderMaxValue = 100
        // MARK: defaultValue should be set by selection of pizza style since it differs per type!
        _amountOfWaterSlider.sliderDefaultValue = 65

        let horizontalStackView: UIStackView = {
            let stackView = UIStackView()

            stackView.axis = .horizontal
            stackView.spacing = 5
            stackView.translatesAutoresizingMaskIntoConstraints = false

            return stackView
        }()

        _holderStackView.addArrangedSubview(_amountOfWaterTitle)
        _amountOfWaterTitle.text = "Amount of water"

        _holderStackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(_amountOfWaterSlider)
        horizontalStackView.addArrangedSubview(_amountOfWaterSliderLabel)
        _amountOfWaterSliderLabel.width(60)
        _amountOfWaterSliderLabel.textAlignment = .center
    }

    @objc func calculatePizzaDough() {
        _viewModel.calculatePizzaIngredients(
            selectedPizzaOption: _viewModel.selectedPizzaStyleOption,
            selectedYeastOption: _viewModel.selectedYeastTypeOption,
            selectedNumberOfPizza: Int(_viewModel.selectedNumberOfPizza),
            selectedSizeOfPizza: Int(_viewModel.selectedSizeOfPizza),
            selectedPercentageOfWater: Int(_viewModel.selectedPercentageOfWater)
        )

        print("""
            \(_viewModel.selectedPizzaStyleOption),
            \(_viewModel.selectedYeastTypeOption),
            \(_viewModel.selectedNumberOfPizza),
            \(_viewModel.selectedSizeOfPizza),
            \(_viewModel.selectedPercentageOfWater)
            """
        )
    }
}
