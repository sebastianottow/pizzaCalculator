//
//  CustomFloatingLabelInput.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 07.08.23.
//

import UIKit


class CustomFloatingLabelInput: UITextField {

    var floatingLabel: UILabel = UILabel(frame: CGRect.zero)

    var floatingLabelHeight: CGFloat = 14

    var _placeholder: String?

    var floatingLabelColor: UIColor = UIColor.black {
        didSet {
            self.floatingLabel.textColor = floatingLabelColor
            self.setNeedsDisplay()
        }
    }

    var activeBorderColor: UIColor = UIColor.blue

    var floatingLabelFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            self.floatingLabel.font = self.floatingLabelFont
            self.font = self.floatingLabelFont
            self.setNeedsDisplay()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self._placeholder = (self._placeholder != nil) ? self._placeholder : placeholder
        placeholder = self._placeholder

        self.floatingLabel = UILabel(frame: CGRect.zero)

        self.addTarget(self, action: #selector(self.addFloatingLabel), for: .editingDidBegin)

        self.addTarget(self, action: #selector(self.removeFloatingLabel), for: .editingDidEnd)
    }

    @objc func addFloatingLabel() {
        if self.text == "" {

            self.floatingLabel.textColor = floatingLabelColor
            self.floatingLabel.font = floatingLabelFont
            self.floatingLabel.text = self._placeholder
            self.floatingLabel.layer.backgroundColor = UIColor.white.cgColor
            self.floatingLabel.translatesAutoresizingMaskIntoConstraints = false
            self.floatingLabel.clipsToBounds = true
            self.floatingLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.floatingLabelHeight)

            self.layer.borderColor = self.activeBorderColor.cgColor
            self.addSubview(self.floatingLabel)

            self.floatingLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -10).isActive = true

            self.placeholder = ""
        }

        self.setNeedsDisplay()
    }

    @objc func removeFloatingLabel() {
        if self.text == "" {

            UIView.animate(withDuration: 0.13) {

                self.subviews.forEach { $0.removeFromSuperview() }
                self.setNeedsDisplay()

            }

            self.placeholder = self._placeholder
        }

        self.layer.borderColor = UIColor.black.cgColor
    }
}
