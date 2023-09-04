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

    private let _receipeViewModel = ReceipeViewModel()
    
    private var _cancellables = Set<AnyCancellable>()

    private let _handMadeLabel = UILabel()
    private let _thermomixLabel = UILabel()

    private let _switchHolderStackView: UIStackView = {
        let stack = UIStackView()

        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.spacing = 10

        return stack
    }()

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

        _doughMixingSwitch.addTarget(self, action: #selector(switchStateDidChanage), for: .valueChanged)
        _doughMixingSwitch.setOn(true, animated: true)

        view.addSubview(_holderStackView)
        _holderStackView.addArrangedSubview(_switchHolderStackView)
        _holderStackView.edgesToSuperview(excluding: .bottom, insets: .init(top: 0, left: 10, bottom: 0, right: 10))

        _switchHolderStackView.addArrangedSubview(_thermomixLabel)
        _switchHolderStackView.addArrangedSubview(_doughMixingSwitch)
        _switchHolderStackView.addArrangedSubview(_handMadeLabel)

        _handMadeLabel.text = "Hand made"
        _thermomixLabel.text = "Thermomix"

        _switchHolderStackView.edgesToSuperview(excluding: [.left, .bottom, .right], insets: .init(top: 100, left: 0, bottom: 0, right: 0))
        _switchHolderStackView.centerXToSuperview()

    }

    @objc func switchStateDidChanage(_ sender: UISwitch) {

        if (sender.isOn == true) {
            _receipeViewModel.handMade = true
        } else {
            _receipeViewModel.thermomix = true
        }
    }

    // MARK: add switch to choose between handmade and thermomix
}
