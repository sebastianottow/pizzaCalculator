//
//  ReceipeView.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 18.09.23.
//

import UIKit


class ReceipeView: UIView {

    let selectedPizzaStyleTitle = UILabel()
    let amountOfFlourRequired = UILabel()
    let amountOfWaterRequired = UILabel()
    let amountOfSaltRequired = UILabel()
    let amountOfYeastRequired = UILabel()

    
    private let _holderStackView: UIStackView = {
        let stack = UIStackView()

        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.spacing = 10

        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        self.addSubview(_holderStackView)
        
        _holderStackView.edgesToSuperview(insets: .init(top: 10, left: 0, bottom: 10, right: 0))
        
        _holderStackView.addArrangedSubview(selectedPizzaStyleTitle)
        selectedPizzaStyleTitle.numberOfLines = 0
        selectedPizzaStyleTitle.lineBreakMode = .byWordWrapping
        
        _holderStackView.addArrangedSubview(amountOfFlourRequired)
        _holderStackView.addArrangedSubview(amountOfWaterRequired)
        _holderStackView.addArrangedSubview(amountOfSaltRequired)
        _holderStackView.addArrangedSubview(amountOfYeastRequired)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
