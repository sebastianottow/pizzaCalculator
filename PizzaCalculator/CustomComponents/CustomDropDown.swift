//
//  CustomDropDown.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 31.07.23.
//

import UIKit
import Combine


final class CustomDropDown: UITextField, UITextFieldDelegate {
    
    enum Constants {
    static let defaultAttributedPlaceholder: String = "Bitte wählen"
    static let defaultAttributedPlaceholderTextColor: UIColor = .darkGray
    }

    let pickerView = UIPickerView()
    

    @Published var value: Int?

    var options: [String?] = [] {
        didSet {
            options.insert("Bitte wählen", at: 0)
        }
    }

    let padding = UIEdgeInsets(top: 10, left: 40, bottom: 10, right: 10)

    func createPickerView() {
        pickerView.delegate = self
        inputView = pickerView
        
        setDefaultAttributedPlaceholder(defaultAttributedPlaceholder: Constants.defaultAttributedPlaceholder)

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

    private func selectText(for index: Int) {
        text = options[index]
    }
    
    func setDefaultAttributedPlaceholder(defaultAttributedPlaceholder: String) {
        attributedPlaceholder =
        NSAttributedString(string: defaultAttributedPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: Constants.defaultAttributedPlaceholderTextColor])
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
        options.count
    }
}

extension CustomDropDown: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: String(options[row] ?? ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
          }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var row = row

        if row == 0 {
            pickerView.selectRow(row + 1, inComponent: 0, animated: true)

            row += 1
        }

        value = row
        selectText(for: row)
    }
}
