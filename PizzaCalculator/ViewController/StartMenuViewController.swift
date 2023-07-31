//
//  StartMenuViewController.swift
//  PizzaCalculator
//
//  Created by Sebastian Ottow on 16.07.23.
//

import UIKit
import TinyConstraints


class StartMenuViewController: UIViewController {
    
    private var _backgroundView: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "pizzaParty")?.withTintColor(.lightGray)
        view.alpha = 0.2
        
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(_backgroundView)
        _backgroundView.centerYToSuperview()
        _backgroundView.centerXToSuperview()
    }
}
