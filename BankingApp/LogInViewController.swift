import Foundation
import UIKit
import PureLayout

class LoginViewController: UIViewController {
    
    private var loginButton: UIButton!
    private var pinContainerView: UIView!
    private var pinField: UITextField!
    private var insertPinLabel: UILabel!
    private var wrongPinLabel: UILabel!
    
    var coordinator: AppCoordinator!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        createViews()
        customizeViews()
        defineViewLayout()
        
    }
    
    private func createViews() {
        
        loginButton = UIButton()
        pinContainerView = UIView()
        insertPinLabel = UILabel()
        pinField = UITextField()
        wrongPinLabel = UILabel()
        
        view.addSubview(loginButton)
        view.addSubview(insertPinLabel)
        view.addSubview(pinContainerView)
        view.addSubview(pinField)
        view.addSubview(wrongPinLabel)
        
    }
    
    private func customizeViews() {
        view.backgroundColor = .white
        
        loginButton.setAttributedTitle(NSMutableAttributedString().bold("Log In", fontSize: 24), for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 8
        loginButton.backgroundColor = UIColor(red: 0, green: 0.8235, blue: 0.9882, alpha: 1.0)
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed(_:)), for: .touchUpInside)
        
        insertPinLabel.attributedText = NSMutableAttributedString().normal("Insert pin", fontSize: 18)
        insertPinLabel.textColor = .black
        
        pinField.attributedText = NSMutableAttributedString().normal("", fontSize: 18)
        pinField.textColor = .black
        pinField.delegate = self
        pinField.keyboardType = .numberPad
        pinField.isSecureTextEntry = true
        pinField.becomeFirstResponder()
        
        pinContainerView.layer.borderColor = UIColor.black.cgColor
        pinContainerView.layer.borderWidth = 1
        pinContainerView.layer.cornerRadius = 10
        
        wrongPinLabel.attributedText = NSMutableAttributedString().normal("", fontSize: 18)
        wrongPinLabel.textColor = .red
    }
    
    private func defineViewLayout() {
        
        loginButton.autoSetDimension(.width, toSize: view.frame.width/2)
        loginButton.autoSetDimension(.height, toSize: view.frame.width/10)
        loginButton.autoAlignAxis(toSuperviewAxis: .vertical)
        loginButton.autoPinEdge(.top, to: .bottom, of: pinField, withOffset: 50)
        
        insertPinLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 10)
        insertPinLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 10)
        insertPinLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 100)
        insertPinLabel.autoSetDimension(.height, toSize: 30)
        
        pinContainerView.autoPinEdge(.leading, to: .leading, of: insertPinLabel)
        pinContainerView.autoPinEdge(.trailing, to: .trailing, of: insertPinLabel)
        pinContainerView.autoPinEdge(.top, to: .bottom, of: insertPinLabel, withOffset: 10)
        pinContainerView.autoSetDimension(.height, toSize: 40)
        
        pinField.autoPinEdge(.top, to: .top, of: pinContainerView)
        pinField.autoPinEdge(.bottom, to: .bottom, of: pinContainerView)
        pinField.autoPinEdge(.leading, to: .leading, of: pinContainerView, withOffset: 10)
        pinField.autoPinEdge(.trailing, to: .trailing, of: pinContainerView, withOffset: 10)
        
        wrongPinLabel.autoPinEdge(.top, to: .bottom, of: pinContainerView, withOffset: 10)
        wrongPinLabel.autoPinEdge(.leading, to: .leading, of: pinContainerView)
        wrongPinLabel.autoPinEdge(.trailing, to: .trailing, of: pinContainerView)
    }
    
    @objc func loginButtonPressed(_ sender: UIButton) {
        let s = pinField.attributedText?.string
        pinField.attributedText = NSMutableAttributedString().normal("", fontSize: 18)
        if (checkPin(pin: s!)) {
            coordinator.loginSuccessful()
        } else {
            animate()
            wrongPinLabel.attributedText = NSMutableAttributedString().normal("Wrong Pin!", fontSize: 18)
            insertPinLabel.textColor = .red
            pinContainerView.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    private func checkPin(pin: String) -> Bool {
        // For Testing
        pin == "1111"
    }
    
    private func animate() {
        let animationDuration = 0.5
        let shakeOffset: CGFloat = 7
        
        // Get a reference to the view you want to animate
        let viewToAnimate = pinContainerView
        
        // Create the keyframe animation
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0, options: [], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.125) {
                viewToAnimate!.transform = CGAffineTransform(translationX: -shakeOffset, y: 0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.125, relativeDuration: 0.25) {
                viewToAnimate!.transform = CGAffineTransform(translationX: shakeOffset, y: 0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.375, relativeDuration: 0.25) {
                viewToAnimate!.transform = CGAffineTransform(translationX: -shakeOffset, y: 0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.625, relativeDuration: 0.25) {
                viewToAnimate!.transform = CGAffineTransform(translationX: shakeOffset, y: 0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.875, relativeDuration: 0.125) {
                viewToAnimate!.transform = .identity
            }
            
        }, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        pinContainerView.layer.borderColor = UIColor.black.cgColor
        insertPinLabel.textColor = .black
        wrongPinLabel.attributedText = NSMutableAttributedString().normal("", fontSize: 18)
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

extension NSMutableAttributedString {
    
    func bold(_ value:String, fontSize size: CGFloat) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont(name: "AvenirNext-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value:String, fontSize size: CGFloat) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont(name: "AvenirNext-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
}
