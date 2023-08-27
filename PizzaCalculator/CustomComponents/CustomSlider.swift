//
//  CustomSlider.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 18.08.23.
//

import Combine
import TinyConstraints
import UIKit


final class CustomSlider: UISlider {

    @Published var selectedValue: Float?

    var sliderDefaultValue: Float = 0.0 {
        didSet {
            self.setValue(sliderDefaultValue , animated: true)
        }
    }

    var sliderMinValue: Float = 0.0 {
        didSet {
            self.minimumValue = sliderMinValue
        }
    }

    var sliderMaxValue: Float = 0.0 {
        didSet {
            self.maximumValue = sliderMaxValue
        }
    }

    var sliderIsContinuous: Bool = true {
        didSet {
            self.isContinuous = sliderIsContinuous
        }
    }

    var sliderTintColour: UIColor = UIColor(red: 0.91, green: 0.37, blue: 0.31, alpha: 1.00) {
        didSet {
            self.tintColor = sliderTintColour
        }
    }

    var sliderThumbIcon: UIImage = UIImage(systemName: "circle")! {
        didSet {
            self.setThumbImage(sliderThumbIcon, for: .normal)
        }
    }

    func createSlider() {
        setupUI()
    }

    private func setupUI() {

        setValue(sliderDefaultValue , animated: true)
        minimumValue = sliderMinValue
        maximumValue = sliderMaxValue
        isContinuous = sliderIsContinuous
        tintColor = sliderTintColour
        setThumbImage(sliderThumbIcon, for: .normal)

        addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
    }

    @objc func sliderValueDidChange(_ sender: UISlider!) {
        let step: Float = 1

        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue

        selectedValue = roundedStepValue
    }
}
