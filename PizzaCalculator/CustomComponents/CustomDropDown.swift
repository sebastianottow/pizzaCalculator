//
//  CustomDropDown.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 31.07.23.
//

import UIKit
import Combine


final class CustomDropDown: UITextField, UITextFieldDelegate {

    let pickerView = UIPickerView()

    @Published var selectedValue: String?

    var selectionList = [String?]()

    let padding = UIEdgeInsets(top: 10, left: 40, bottom: 10, right: 10)

    func createPickerView() {

        pickerView.delegate = self
        inputView = pickerView

        setupUI()
    }

    func setIcon(icon: UIImage?, color: UIColor?) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = icon
        iconView.tintColor = color

        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)

        leftView = iconContainerView
        leftViewMode = .always
    }

    private func setupUI() {
        layer.borderWidth = 3
        layer.borderColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00).cgColor
        layer.cornerRadius = 5
        tintColor = UIColor.clear
    }

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

}

extension CustomDropDown: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return selectionList.count
    }
}

extension CustomDropDown: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selectionList[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = selectionList[row]

        text = selectedValue
    }
}
