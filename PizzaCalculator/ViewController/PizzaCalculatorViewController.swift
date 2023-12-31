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
    
    private var _didChangeSelectedOption: Bool? = false {
        didSet {
            resetToDefaultValue()
        }
    }

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
        
        view.backgroundColor = .white

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
                
                self._didChangeSelectedOption = true
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
        _pizzaStylePicker.setIcon(icon: Asset.iconDropDown.image, color: nil)
        _pizzaStylePickerTitle.text = "Pizza Style"
        _pizzaStylePickerTitle.textColor = .black
        _holderStackView.addArrangedSubview(_pizzaStylePicker)
        _pizzaStylePicker.height(55)
        _pizzaStylePicker.options = _viewModel.pizzaStyleOptions.map { $0.rawValue }
        
        _typeOfYeastPicker.createPickerView()
        _holderStackView.addArrangedSubview(_typeOfYeastTitle)
        _typeOfYeastPicker.setIcon(icon: Asset.iconDropDown.image, color: nil)
        _pizzaStylePickerTitle.text = "Pizza Style"
        _typeOfYeastTitle.textColor = .black
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
    
    private func resetToDefaultValue() {
        _viewModel.selectedSizeOfPizza = Float(_viewModel.selectedPizzaStyleOption.defaultPizzaSize)
        _viewModel.selectedPercentageOfWater = Float(_viewModel.selectedPizzaStyleOption.defaultPercentageOfWater)
    }

    private func setupNumberOfPizzaSlider() {
        _numberOfPizzasSlider.createSlider()
        _numberOfPizzasSlider.sliderMinValue = 1
        _numberOfPizzasSlider.sliderMaxValue = 20
        _numberOfPizzasSlider.sliderDefaultValue = 4
        _numberOfPizzasSlider.sliderThumbIcon = Asset.iconMultiplePeople.image.scale(setWidth: 25)

        let horizontalStackView: UIStackView = {
            let stackView = UIStackView()

            stackView.axis = .horizontal
            stackView.spacing = 5
            stackView.translatesAutoresizingMaskIntoConstraints = false

            return stackView
        }()

        _holderStackView.addArrangedSubview(_numberOfPizzasTitle)
        _numberOfPizzasTitle.textColor = .black
        _numberOfPizzasTitle.text = "Number of Pizzas"

        _holderStackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(_numberOfPizzasSlider)
        horizontalStackView.addArrangedSubview(_numberOfPizzasSliderLabel)
        _numberOfPizzasSliderLabel.textColor = .black
        _numberOfPizzasSliderLabel.width(60)
        _numberOfPizzasSliderLabel.textAlignment = .center
    }

    private func setupSizeOfPizzasSlider() {
        _sizeOfPizzasSlider.createSlider()
        _sizeOfPizzasSlider.sliderMinValue = 150
        _sizeOfPizzasSlider.sliderMaxValue = 1_000
        _sizeOfPizzasSlider.sliderDefaultValue = 230
        _sizeOfPizzasSlider.sliderThumbIcon = Asset.iconSizeSlider.image.scale(setWidth: 25)

        let horizontalStackView: UIStackView = {
            let stackView = UIStackView()

            stackView.axis = .horizontal
            stackView.spacing = 5
            stackView.translatesAutoresizingMaskIntoConstraints = false

            return stackView
        }()

        _holderStackView.addArrangedSubview(_sizeOfPizzasTitle)
        _sizeOfPizzasTitle.textColor = .black
        _sizeOfPizzasTitle.text = "Size of Pizza"

        _holderStackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(_sizeOfPizzasSlider)
        horizontalStackView.addArrangedSubview(_sizeOfPizzasSliderLabel)
        _sizeOfPizzasSliderLabel.textColor = .black
        _sizeOfPizzasSliderLabel.width(60)
        _sizeOfPizzasSliderLabel.textAlignment = .center
    }

    private func setupAmountOfWaterSlider() {
        _amountOfWaterSlider.createSlider()
        _amountOfWaterSlider.sliderMinValue = 0
        _amountOfWaterSlider.sliderMaxValue = 100
        _amountOfWaterSlider.sliderDefaultValue = 65
        _amountOfWaterSlider.sliderThumbIcon = Asset.iconWaterSlider.image.scale(setWidth: 25)

        let horizontalStackView: UIStackView = {
            let stackView = UIStackView()

            stackView.axis = .horizontal
            stackView.spacing = 5
            stackView.translatesAutoresizingMaskIntoConstraints = false

            return stackView
        }()

        _holderStackView.addArrangedSubview(_amountOfWaterTitle)
        _amountOfWaterTitle.textColor = .black
        _amountOfWaterTitle.text = "Amount of water"

        _holderStackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(_amountOfWaterSlider)
        horizontalStackView.addArrangedSubview(_amountOfWaterSliderLabel)
        _amountOfWaterSliderLabel.textColor = .black
        _amountOfWaterSliderLabel.width(60)
        _amountOfWaterSliderLabel.textAlignment = .center
    }

    @objc func calculatePizzaDough() {
        _viewModel.calculatePizzaIngredients(
            selectedPizzaOption: _viewModel.selectedPizzaStyleOption,
            selectedYeastOption: _viewModel.selectedYeastTypeOption,
            selectedNumberOfPizza: Double(_viewModel.selectedNumberOfPizza),
            selectedSizeOfPizza: Double(_viewModel.selectedSizeOfPizza),
            selectedPercentageOfWater: Double(_viewModel.selectedPercentageOfWater)
        )

        self.navigationController?.pushViewController(ReceipeViewController(viewModel: _viewModel), animated: true)
    }
}
