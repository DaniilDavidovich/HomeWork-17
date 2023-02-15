//
//  View.swift
//  Pr2503
//
//  Created by Daniil Davidovich on 15.02.23.
//

import UIKit

class View: UIView {
    
    //MARK: - UI Elements
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Your Password."
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 20
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.borderWidth = 3
        textField.attributedPlaceholder = NSAttributedString(string: "Random Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        textField.textAlignment = .center
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var buttonRandomPassword: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.setTitle("Generate Password", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var buttonPasswordSelection: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.setTitle("Password selection", for: .normal)
        button.setTitleColor(.black, for: .normal)

        return button
    }()
    
    lazy var buttonChangeColor: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.setTitle("Change Color", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var buttonStopSelection: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.setTitle("Stop Selection", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var activituIndicator: UIActivityIndicatorView = {
        let activituIndicator = UIActivityIndicatorView(style: .large)
        activituIndicator.isHidden = true
        activituIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activituIndicator
    }()
    
    //MARK: - Inits

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupHierachy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
    //MARK: - Setups
    
    func setupHierachy() {
        addSubview(buttonRandomPassword)
        addSubview(buttonPasswordSelection)
        addSubview(textField)
        addSubview(label)
        addSubview(buttonChangeColor)
        addSubview(buttonStopSelection)
        addSubview(activituIndicator)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: textField.centerYAnchor, constant: 100),
            
            buttonRandomPassword.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
            buttonRandomPassword.leadingAnchor.constraint(equalTo: leadingAnchor ,constant: 30),
            buttonRandomPassword.heightAnchor.constraint(equalToConstant: 50),
            buttonRandomPassword.widthAnchor.constraint(equalToConstant: 150),
            
            buttonPasswordSelection.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
            buttonPasswordSelection.trailingAnchor.constraint(equalTo: trailingAnchor ,constant: -30),
            buttonPasswordSelection.heightAnchor.constraint(equalToConstant: 50),
            buttonPasswordSelection.widthAnchor.constraint(equalToConstant: 150),
            
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            
            buttonChangeColor.topAnchor.constraint(equalTo: buttonRandomPassword.bottomAnchor, constant: 20),
            buttonChangeColor.leadingAnchor.constraint(equalTo: buttonRandomPassword.leadingAnchor),
            buttonChangeColor.heightAnchor.constraint(equalToConstant: 50),
            buttonChangeColor.widthAnchor.constraint(equalToConstant: 150),
            
            buttonStopSelection.topAnchor.constraint(equalTo: buttonPasswordSelection.bottomAnchor, constant: 20),
            buttonStopSelection.trailingAnchor.constraint(equalTo: buttonPasswordSelection.trailingAnchor),
            buttonStopSelection.heightAnchor.constraint(equalToConstant: 50),
            buttonStopSelection.widthAnchor.constraint(equalToConstant: 150),
            
            activituIndicator.topAnchor.constraint(equalTo: label.topAnchor, constant: -10),
            activituIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        ])
    }
}
