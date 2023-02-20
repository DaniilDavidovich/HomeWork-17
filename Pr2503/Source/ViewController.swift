import UIKit

@available(iOS 15.0, *)
class ViewController: UIViewController {
    
    private lazy var myView: View = {
        View()
    }()

    //MARK: - Observers
    
    var textLabel: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.myView.label.text = self.textLabel
            }
        }
    }
    
    var isPink: Bool = false {
        didSet {
            if isPink {
                myView.imageView.tintColor = .systemPink
            } else {
                myView.imageView.tintColor = .systemCyan
            }
        }
    }
    
    var isSecureText: Bool = false {
        didSet {
            if isSecureText {
                DispatchQueue.main.async {
                    self.myView.textField.isSecureTextEntry = true
                }
            } else {
                DispatchQueue.main.async {
                    self.myView.textField.isSecureTextEntry = false
                }
            }
        }
    }
    
    var isStarted: Bool = false {
        didSet {
            isStarted.toggle()
        }
    }
    
    //MARK: - Lyfecycle
    
    override func loadView() {
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        addTarget()
    }
    
    //MARK: - @objc Methods
    
    var workItem: DispatchWorkItem?
    
    @objc func passwordSelection() {
            
        let text = self.myView.textField.text ?? ""
        self.myView.activituIndicator.startAnimating()
        isStarted = true
        
        workItem = DispatchWorkItem {
            self.bruteForce(passwordToUnlock: text)
        }
        
        if let workItem { DispatchQueue.global().async(execute: workItem) }
    }
    
    @objc func addRandomPasswordToTextField() {
        isSecureText = true
        myView.label.text = "Your Password."
        myView.textField.text = randomPassword()
    }
    
    @objc func changeColor() {
            if !isPink {
                isPink = true
            } else {
                isPink = false
            }
    }
    
    @objc func stopSelection() {
        isStarted = false
    }
    
    //MARK: - Methods
    
    //MARK: Find password
    func bruteForce(passwordToUnlock: String) {
        let allowedCharacters: [String] = String().printable.map { String($0) }

        var password: String = ""

        while password != passwordToUnlock {
            
            if isStarted == false {
                
                isStarted = true
                password = generateBruteForce(password, fromArray: allowedCharacters)
                print(password)
                textLabel = password
            } else {
                
                isStarted = false
                password = "not found"
                textLabel = password
    
                DispatchQueue.main.async {
                    self.myView.activituIndicator.stopAnimating()
                }
                break
            }
        }
        
        if password == passwordToUnlock {
            
            DispatchQueue.main.async {
                self.isSecureText = false
                self.myView.activituIndicator.stopAnimating()
           }
            
            DispatchQueue(label: "Sleep", qos: .userInteractive).async {
                    sleep(1)
                    self.isSecureText = true
            }
        }
        self.textLabel = "Password is \(password)."
        print("Password is \(password).")
    }
    
    //MARK: Generate random pasword
    
    @objc func randomPassword() -> String {
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
    
    //MARK: Target to buttons
    
    func addTarget() {
        myView.buttonChangeColor.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        myView.buttonStopSelection.addTarget(self, action: #selector(stopSelection), for: .touchUpInside)
        myView.buttonRandomPassword.addTarget(self, action: #selector(addRandomPasswordToTextField), for: .touchUpInside)
        myView.buttonPasswordSelection.addTarget(self, action: #selector(passwordSelection), for: .touchUpInside)
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

extension UIViewController {

func hideKeyboardWhenTappedAround() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
}

@objc func dismissKeyboard() {
    view.endEditing(true)
    }
}

