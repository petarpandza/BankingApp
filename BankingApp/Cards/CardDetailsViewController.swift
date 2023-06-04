import Foundation
import UIKit
import PureLayout

class CardDetailsViewController: UIViewController {
    
    var coordinator: AppCoordinator!
    
    private var card: Card!
    
    private var cardContainerView: UIView!
    private var cardNumberLiteralLabel: UILabel!
    private var cardNumberLabel: UILabel!
    private var cardExpiryDateLiteralLabel: UILabel!
    private var cardExpiryDateLabel: UILabel!
    private var cardCVVLiteralLabel: UILabel!
    private var cardCVVLabel: UILabel!
    
    private var showCardNumberButton: UIButton!
    
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    
    init(_ coordinator: AppCoordinator, card: Card) {
        self.coordinator = coordinator
        self.card = card
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {

        createViews()
        customizeViews()
        defineViewLayout()
        registerViewCells()
        
    }

    private func createViews() {
        
        layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width*0.95, height: view.frame.width*0.2)
        layout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.addSubview(collectionView)
        
        cardContainerView = UIView()
        cardNumberLabel = UILabel()
        cardExpiryDateLabel = UILabel()
        cardCVVLabel = UILabel()
        cardNumberLiteralLabel = UILabel()
        cardExpiryDateLiteralLabel = UILabel()
        cardCVVLiteralLabel = UILabel()
        
        showCardNumberButton = UIButton()
        
        view.addSubview(cardContainerView)
        cardContainerView.addSubview(cardNumberLabel)
        cardContainerView.addSubview(cardExpiryDateLabel)
        cardContainerView.addSubview(cardCVVLabel)
        cardContainerView.addSubview(cardNumberLiteralLabel)
        cardContainerView.addSubview(cardExpiryDateLiteralLabel)
        cardContainerView.addSubview(cardCVVLiteralLabel)
        cardContainerView.addSubview(showCardNumberButton)
    }
    
    private func customizeViews() {
        view.backgroundColor = .white
        self.title = card.cardName
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cardContainerView.backgroundColor = .white
        cardContainerView.layer.borderWidth = 1
        cardContainerView.layer.borderColor = UIColor.black.cgColor
        cardContainerView.layer.cornerRadius = 20
        
        cardNumberLabel.attributedText = NSMutableAttributedString().normal(hideCardNumber(card.cardNumber), fontSize: 20)
        cardExpiryDateLabel.attributedText = NSMutableAttributedString().normal(card.expiryDate, fontSize: 20)
        cardCVVLabel.attributedText = NSMutableAttributedString().normal(card.CVV, fontSize: 20)
        
        cardNumberLiteralLabel.attributedText = NSMutableAttributedString().normal("Card Number", fontSize: 18)
        cardExpiryDateLiteralLabel.attributedText = NSMutableAttributedString().normal("Expiry Date", fontSize: 18)
        cardCVVLiteralLabel.attributedText = NSMutableAttributedString().normal("CVV", fontSize: 18)
        
        cardNumberLiteralLabel.textColor = .gray
        cardExpiryDateLiteralLabel.textColor = .gray
        cardCVVLiteralLabel.textColor = .gray
        
        let eyeImage = UIImage(systemName: "eye.fill", withConfiguration: .none)
        let eyeSlashImage = UIImage(systemName: "eye.slash", withConfiguration: .none)
        showCardNumberButton.setImage(eyeSlashImage, for: .normal)
        showCardNumberButton.setImage(eyeImage, for: .selected)
        showCardNumberButton.addTarget(self, action: #selector(showNumberSelected(_:)), for: .touchUpInside)
        showCardNumberButton.tintColor = .black
        
    }
    
    private func defineViewLayout() {
            
        
        
        cardContainerView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 10)
        cardContainerView.autoAlignAxis(toSuperviewAxis: .vertical)
        let cardWidth = view.frame.width*0.9
        cardContainerView.autoSetDimension(.width, toSize: cardWidth)
        cardContainerView.autoSetDimension(.height, toSize: cardWidth*0.63)
        
        collectionView.autoPinEdge(.top, to: .bottom, of: cardContainerView, withOffset: 30)
        collectionView.autoPinEdge(toSuperviewSafeArea: .leading)
        collectionView.autoPinEdge(toSuperviewSafeArea: .trailing)
        collectionView.autoPinEdge(toSuperviewSafeArea: .bottom)
        
        cardNumberLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        cardNumberLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        cardExpiryDateLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        cardExpiryDateLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        
        cardCVVLabel.autoPinEdge(.top, to: .top, of: cardExpiryDateLabel)
        cardCVVLabel.autoPinEdge(.leading, to: .leading, of: cardCVVLiteralLabel)
        
        cardNumberLiteralLabel.autoPinEdge(.leading, to: .leading, of: cardNumberLabel)
        cardNumberLiteralLabel.autoPinEdge(.bottom, to: .top, of: cardNumberLabel)
        
        cardExpiryDateLiteralLabel.autoPinEdge(.leading, to: .leading, of: cardExpiryDateLabel)
        cardExpiryDateLiteralLabel.autoPinEdge(.bottom, to: .top, of: cardExpiryDateLabel)
        
        cardCVVLiteralLabel.autoPinEdge(.leading, to: .trailing, of: cardExpiryDateLiteralLabel, withOffset: 30)
        cardCVVLiteralLabel.autoPinEdge(.bottom, to: .top, of: cardCVVLabel)
        
        showCardNumberButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        showCardNumberButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        
    }
    
    private func registerViewCells() {
        collectionView.register(TransactionViewCell.self, forCellWithReuseIdentifier: "card details")
    }
    
    private func hideCardNumber(_ number: String) -> String {
        guard number.count == 16 else {
            return ""
        }
        
        let range = number.index(number.startIndex, offsetBy: 6)..<number.index(number.startIndex, offsetBy: 12)
        
        return number.replacingCharacters(in: range, with: String(repeating: "X", count: 6))
    }
    
    @objc func showNumberSelected(_ sender: UIButton) {
        
        if (sender.isSelected) {
            cardNumberLabel.attributedText = NSMutableAttributedString().normal(hideCardNumber(card.cardNumber), fontSize: 20)
        } else {
            cardNumberLabel.attributedText = NSMutableAttributedString().normal(card.cardNumber, fontSize: 20)
        }
        
        sender.isSelected = !sender.isSelected
    }
}

extension CardDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
}

extension CardDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return card.transactions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "card details", for: indexPath) as? TransactionViewCell else {
            fatalError("Unable to dequeue cell")
        }
        
        cell.setTransaction(transaction: card.transactions[indexPath.row])
        
        return cell
    }
    
    
}



