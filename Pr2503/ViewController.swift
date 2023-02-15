import UIKit

class ViewController: UIViewController {
    
    //MARK: - UI Elements
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Your Password."
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textField: UITextField = {
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
    
    private lazy var buttonRandomPassword: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.setTitle("Generate Password", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(addRandomPasswordToTextField), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonPasswordSelection: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.setTitle("Password selection", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(passwordSelection), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonChangeColor: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.setTitle("Change Color", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStopSelection: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.setTitle("Stop Selection", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(stopSelection), for: .touchUpInside)
        return button
    }()
    
    private lazy var activituIndicator: UIActivityIndicatorView = {
        let activituIndicator = UIActivityIndicatorView(style: .large)
        activituIndicator.isHidden = true
        activituIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activituIndicator
    }()
    
    //MARK: - Observers
    
    var textLabel: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.label.text = self.textLabel
            }
        }
    }
    
    var isBlack: Bool = false {
        didSet {
            if isBlack {
                view.backgroundColor = .black
                label.textColor = .white
                textField.textColor = .white
            } else {
                self.view.backgroundColor = .white
                label.textColor = .black
                textField.textColor = .black
            }
        }
    }
    
    var isSecureText: Bool = false {
        didSet {
            if isSecureText {
                DispatchQueue.main.async {
                    self.textField.isSecureTextEntry = true
                }
            } else {
                DispatchQueue.main.async {
                    self.textField.isSecureTextEntry = false
                }
            }
        }
    }
    
    var isStarted: Bool = false {
        didSet {
            if isStarted {
                isStarted = false
            } else {
                isStarted = true
            }
        }
    }
    
    //MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierachy()
        setupLayout()
    }
    
    //MARK: - Setups
    
    func setupHierachy() {
        view.addSubview(buttonRandomPassword)
        view.addSubview(buttonPasswordSelection)
        view.addSubview(textField)
        view.addSubview(label)
        view.addSubview(buttonChangeColor)
        view.addSubview(buttonStopSelection)
        view.addSubview(activituIndicator)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: textField.centerYAnchor, constant: 100),
            
            buttonRandomPassword.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
            buttonRandomPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor ,constant: 30),
            buttonRandomPassword.heightAnchor.constraint(equalToConstant: 50),
            buttonRandomPassword.widthAnchor.constraint(equalToConstant: 150),
            
            buttonPasswordSelection.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
            buttonPasswordSelection.trailingAnchor.constraint(equalTo: view.trailingAnchor ,constant: -30),
            buttonPasswordSelection.heightAnchor.constraint(equalToConstant: 50),
            buttonPasswordSelection.widthAnchor.constraint(equalToConstant: 150),
            
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            
            buttonChangeColor.topAnchor.constraint(equalTo: buttonRandomPassword.bottomAnchor, constant: 20),
            buttonChangeColor.leadingAnchor.constraint(equalTo: buttonRandomPassword.leadingAnchor),
            buttonChangeColor.heightAnchor.constraint(equalToConstant: 50),
            buttonChangeColor.widthAnchor.constraint(equalToConstant: 150),
            
            buttonStopSelection.topAnchor.constraint(equalTo: buttonPasswordSelection.bottomAnchor, constant: 20),
            buttonStopSelection.trailingAnchor.constraint(equalTo: buttonPasswordSelection.trailingAnchor),
            buttonStopSelection.heightAnchor.constraint(equalToConstant: 50),
            buttonStopSelection.widthAnchor.constraint(equalToConstant: 150),
            
            activituIndicator.topAnchor.constraint(equalTo: label.topAnchor, constant: -10),
            activituIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    //MARK: - @objc Methods
    
    var workItem: DispatchWorkItem?
    
    @objc private func passwordSelection() {
            
        let text = self.textField.text ?? ""
        self.activituIndicator.startAnimating()
        isStarted = true
        
        workItem = DispatchWorkItem {
            self.bruteForce(passwordToUnlock: text)
        }
        
        if workItem != nil {
            DispatchQueue.global().async(execute: workItem!)
        }
    }
    
    @objc private func addRandomPasswordToTextField() {
        isSecureText = true
        label.text = "Your Password."
        textField.text = randomPassword()
    }
    
    @objc private func changeColor() {
            if isBlack == false {
                isBlack = true
            } else {
                isBlack = false
            }
    }
    
    @objc private func stopSelection() {
        isStarted = false
    }
    
    //MARK: - Methods
    
    func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }

        var password: String = ""

        while password != passwordToUnlock {
            
            if isStarted == false {
                
                isStarted = true
                password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
                print(password)
                textLabel = password
                
                if password == passwordToUnlock {
                    
                    DispatchQueue.main.async {
                        self.isSecureText = false
                        self.activituIndicator.stopAnimating()
                   }
                    
                    DispatchQueue(label: "Sleep", qos: .userInteractive).async {
                        do {
                            sleep(1)
                            self.isSecureText = true

                        }
                    }

                }
                
            } else {
                isStarted = false
                password = "not found"
                textLabel = password
                
                DispatchQueue.main.async {
                    self.activituIndicator.stopAnimating()
                }
                
                break
            }
        }
        
        self.textLabel = "Password is \(password)."
        print("Password is \(password).")
    }
    
    func randomPassword() -> String {
        var characters = [Character]()
        let symbols = Array(String().printable)
        var password = String()
        
        for _ in 0...symbols.count {
            if characters.count < 3 {
                let randomIndex = Int.random(in: 0..<symbols.count)
                    characters.append(symbols[randomIndex])
            }
        }
        
        password = String(characters)
        print(password)
        return password
    }
}

//MARK: - Extension

extension String {
    var digits: String { return "0123456789" }
    var lowercase: String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase: String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters: String { return lowercase + uppercase }
    var printable: String { return digits + letters + punctuation }

    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

func indexOf(character: Character, _ array: [String]) -> Int {
    return array.firstIndex(of: String(character))!
}

func characterAt(index: Int, _ array: [String]) -> Character {
    return index < array.count ? Character(array[index])
                               : Character("")
}

func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
    var str: String = string

    if str.count <= 0 {
        str.append(characterAt(index: 0, array))
    } else {
        str.replace(at: str.count - 1,
                    with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

        if indexOf(character: str.last!, array) == 0 {
            str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
        }
    }
    return str
}

