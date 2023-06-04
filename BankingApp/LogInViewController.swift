import Foundation
import UIKit
import PureLayout

class LoginViewController: UIViewController {
    
    private var numberButtons: [UIButton]!
    private var deleteButton: UIButton!
    private var loginButton: UIButton!
    private var pinContainerView: UIView!
    private var pinLabel: UILabel!
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
        
        numberButtons = [UIButton]()
        
        for i in 0...9 {
            numberButtons.append(UIButton())
            view.addSubview(numberButtons[i])
        }
        
        deleteButton = UIButton()
        loginButton = UIButton()
        pinContainerView = UIView()
        insertPinLabel = UILabel()
        pinLabel = UILabel()
        wrongPinLabel = UILabel()
        
        view.addSubview(deleteButton)
        view.addSubview(loginButton)
        view.addSubview(insertPinLabel)
        view.addSubview(pinContainerView)
        view.addSubview(pinLabel)
        view.addSubview(wrongPinLabel)
        
    }
    
    private func customizeViews() {
        view.backgroundColor = .white
        
        for i in 0...9 {
            numberButtons[i].setTitle(String(i), for: .normal)
            numberButtons[i].setTitleColor(.black, for: .normal)
            numberButtons[i].tag = i
            numberButtons[i].layer.cornerRadius = 5
            numberButtons[i].layer.shadowColor = UIColor.gray.cgColor
            numberButtons[i].layer.shadowOffset = CGSize(width: 0, height: 1.0)
            numberButtons[i].layer.shadowRadius = 3.0
            numberButtons[i].layer.shadowOpacity = 1
            numberButtons[i].layer.masksToBounds = false
            numberButtons[i].layer.borderColor = UIColor.black.cgColor
            numberButtons[i].layer.borderWidth = 1
            
            numberButtons[i].addTarget(self, action: #selector(pinButtonPressed(_:)), for: .touchUpInside)
        }
        
        let deleteImage = UIImage(systemName: "delete.left", withConfiguration: .none)
        deleteButton.setImage(deleteImage, for: .normal)
        deleteButton.tintColor = .black
        deleteButton.layer.cornerRadius = 5
        deleteButton.layer.shadowColor = UIColor.gray.cgColor
        deleteButton.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        deleteButton.layer.shadowRadius = 3.0
        deleteButton.layer.shadowOpacity = 1
        deleteButton.layer.masksToBounds = false
        deleteButton.layer.borderColor = UIColor.black.cgColor
        deleteButton.layer.borderWidth = 1
        
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed(_:)), for: .touchUpInside)
        
        loginButton.setAttributedTitle(NSMutableAttributedString().bold("Log In", fontSize: 24), for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 8
        loginButton.backgroundColor = UIColor(red: 0, green: 0.8235, blue: 0.9882, alpha: 1.0)
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed(_:)), for: .touchUpInside)
        
        insertPinLabel.attributedText = NSMutableAttributedString().normal("Insert pin", fontSize: 18)
        insertPinLabel.textColor = .black
        
        pinLabel.attributedText = NSMutableAttributedString().normal("", fontSize: 18)
        pinLabel.textColor = .black
        
        pinContainerView.layer.borderColor = UIColor.black.cgColor
        pinContainerView.layer.borderWidth = 1
        pinContainerView.layer.cornerRadius = 10
        
        wrongPinLabel.attributedText = NSMutableAttributedString().normal("", fontSize: 18)
        wrongPinLabel.textColor = .red
    }
    
    private func defineViewLayout() {
        
        let buttonWidth = view.frame.width / 3 - 5
        let buttonHeight = buttonWidth / 3
        for i in 0...9 {
            numberButtons[i].autoSetDimension(.width, toSize: buttonWidth)
            numberButtons[i].autoSetDimension(.height, toSize: buttonHeight)
        }
        numberButtons[0].autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 4)
        numberButtons[0].autoAlignAxis(toSuperviewAxis: .vertical)
        
        numberButtons[8].autoPinEdge(.bottom, to: .top, of: numberButtons[0], withOffset: -4)
        numberButtons[8].autoPinEdge(.leading, to: .leading, of: numberButtons[0])
        numberButtons[5].autoPinEdge(.bottom, to: .top, of: numberButtons[8], withOffset: -4)
        numberButtons[5].autoPinEdge(.leading, to: .leading, of: numberButtons[0])
        numberButtons[2].autoPinEdge(.bottom, to: .top, of: numberButtons[5], withOffset: -4)
        numberButtons[2].autoPinEdge(.leading, to: .leading, of: numberButtons[0])
        numberButtons[1].autoPinEdge(.trailing, to: .leading, of: numberButtons[2], withOffset: -4)
        numberButtons[1].autoPinEdge(.top, to: .top, of: numberButtons[2])
        numberButtons[3].autoPinEdge(.leading, to: .trailing, of: numberButtons[2], withOffset: 4)
        numberButtons[3].autoPinEdge(.top, to: .top, of: numberButtons[2])
        numberButtons[4].autoPinEdge(.trailing, to: .leading, of: numberButtons[2], withOffset: -4)
        numberButtons[4].autoPinEdge(.top, to: .top, of: numberButtons[5])
        numberButtons[6].autoPinEdge(.leading, to: .trailing, of: numberButtons[2], withOffset: 4)
        numberButtons[6].autoPinEdge(.top, to: .top, of: numberButtons[5])
        numberButtons[7].autoPinEdge(.trailing, to: .leading, of: numberButtons[2], withOffset: -4)
        numberButtons[7].autoPinEdge(.top, to: .top, of: numberButtons[8])
        numberButtons[9].autoPinEdge(.leading, to: .trailing, of: numberButtons[2], withOffset: 4)
        numberButtons[9].autoPinEdge(.top, to: .top, of: numberButtons[8])
        
        deleteButton.autoSetDimension(.width, toSize: buttonWidth)
        deleteButton.autoSetDimension(.height, toSize: buttonHeight)
        deleteButton.autoPinEdge(.bottom, to: .top, of: numberButtons[3], withOffset: -4)
        deleteButton.autoPinEdge(.leading, to: .leading, of: numberButtons[3])
        
        loginButton.autoSetDimension(.width, toSize: view.frame.width/2)
        loginButton.autoSetDimension(.height, toSize: view.frame.width/10)
        loginButton.autoAlignAxis(toSuperviewAxis: .vertical)
        loginButton.autoPinEdge(.top, to: .bottom, of: pinLabel, withOffset: 50)
        
        insertPinLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 10)
        insertPinLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 10)
        insertPinLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 100)
        insertPinLabel.autoSetDimension(.height, toSize: 30)
        
        pinContainerView.autoPinEdge(.leading, to: .leading, of: insertPinLabel)
        pinContainerView.autoPinEdge(.trailing, to: .trailing, of: insertPinLabel)
        pinContainerView.autoPinEdge(.top, to: .bottom, of: insertPinLabel, withOffset: 10)
        pinContainerView.autoSetDimension(.height, toSize: 40)
        
        pinLabel.autoPinEdge(.top, to: .top, of: pinContainerView)
        pinLabel.autoPinEdge(.bottom, to: .bottom, of: pinContainerView)
        pinLabel.autoPinEdge(.leading, to: .leading, of: pinContainerView, withOffset: 10)
        pinLabel.autoPinEdge(.trailing, to: .trailing, of: pinContainerView, withOffset: 10)
        
        wrongPinLabel.autoPinEdge(.top, to: .bottom, of: pinContainerView, withOffset: 10)
        wrongPinLabel.autoPinEdge(.leading, to: .leading, of: pinContainerView)
        wrongPinLabel.autoPinEdge(.trailing, to: .trailing, of: pinContainerView)
    }
    
    @objc func pinButtonPressed(_ sender: UIButton) {
        var s = pinLabel.attributedText?.string
        s!.append(String(sender.tag))
        pinLabel.attributedText = NSMutableAttributedString().normal(s!, fontSize: 18)
        wrongPinLabel.attributedText = NSMutableAttributedString().normal("", fontSize: 18)
        insertPinLabel.textColor = .black
        pinContainerView.layer.borderColor = UIColor.black.cgColor
    }
    
    @objc func deleteButtonPressed(_ sender: UIButton) {
        var s = pinLabel.attributedText?.string
        s = String(s!.dropLast(1))
        pinLabel.attributedText = NSMutableAttributedString().normal(s!, fontSize: 18)
    }
    
    @objc func loginButtonPressed(_ sender: UIButton) {
        let s = pinLabel.attributedText?.string
        pinLabel.attributedText = NSMutableAttributedString().normal("", fontSize: 18)
        if (s! == "1111") {
            coordinator.loginSuccessful()
        } else {
            wrongPinLabel.attributedText = NSMutableAttributedString().normal("Wrong Pin!", fontSize: 18)
            insertPinLabel.textColor = .red
            pinContainerView.layer.borderColor = UIColor.red.cgColor
        }
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
    
    func underlined(_ value:String, fontSize size: CGFloat) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont(name: "AvenirNext-Bold", size: size) ?? UIFont.systemFont(ofSize: size),
            .underlineColor : UIColor.black,
            .underlineStyle : 3
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
