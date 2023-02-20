//
//  View.swift
//  Pr2503
//
//  Created by Daniil Davidovich on 15.02.23.
//

import UIKit

@available(iOS 15.0, *)
class View: UIView {
    
    //MARK: - UI Elements
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Your Password."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .medium)
        return label
    }()
    
   lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "heart"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
       imageView.tintColor = .systemCyan
        imageView.backgroundColor = .systemGray3
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
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
        textField.keyboardType = .alphabet
        return textField
    }()
    
    lazy var buttonRandomPassword: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray3
        button.layer.cornerRadius = 20
        button.setTitle("Generate Password", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var buttonPasswordSelection: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray3
        button.layer.cornerRadius = 20
        button.setTitle("Crack password", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var buttonChangeColor: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray3
        button.layer.cornerRadius = 20
        button.setTitle("Change Color Heart", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var buttonStopSelection: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray3
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
        backgroundColor = .systemBackground
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
        addSubview(imageView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 75),
            imageView.leadingAnchor.constraint(equalTo: buttonChangeColor.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: buttonStopSelection.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -40),
            
            label.leadingAnchor.constraint(equalTo: buttonChangeColor.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: textField.centerYAnchor, constant: -75),
            
            buttonRandomPassword.bottomAnchor.constraint(equalTo: buttonChangeColor.topAnchor, constant: -13),
            buttonRandomPassword.leadingAnchor.constraint(equalTo: leadingAnchor ,constant: 30),
            buttonRandomPassword.heightAnchor.constraint(equalToConstant: 120),
            buttonRandomPassword.widthAnchor.constraint(equalToConstant: 160),
            
            buttonPasswordSelection.topAnchor.constraint(equalTo: buttonRandomPassword.topAnchor),
            buttonPasswordSelection.trailingAnchor.constraint(equalTo: trailingAnchor ,constant: -30),
            buttonPasswordSelection.heightAnchor.constraint(equalToConstant: 120),
            buttonPasswordSelection.widthAnchor.constraint(equalToConstant: 160),
            
            textField.bottomAnchor.constraint(equalTo: buttonRandomPassword.topAnchor, constant: -50),
            textField.trailingAnchor.constraint(equalTo: buttonStopSelection.trailingAnchor),
            textField.leadingAnchor.constraint(equalTo: buttonChangeColor.leadingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50),
          
            buttonChangeColor.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            buttonChangeColor.leadingAnchor.constraint(equalTo: buttonRandomPassword.leadingAnchor),
            buttonChangeColor.heightAnchor.constraint(equalToConstant: 120),
            buttonChangeColor.widthAnchor.constraint(equalToConstant: 160),
            
            buttonStopSelection.topAnchor.constraint(equalTo: buttonChangeColor.topAnchor),
            buttonStopSelection.trailingAnchor.constraint(equalTo: buttonPasswordSelection.trailingAnchor),
            buttonStopSelection.heightAnchor.constraint(equalToConstant: 120),
            buttonStopSelection.widthAnchor.constraint(equalToConstant: 160),
            
            activituIndicator.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            activituIndicator.trailingAnchor.constraint(equalTo: buttonPasswordSelection.trailingAnchor)
        ])
    }
}
