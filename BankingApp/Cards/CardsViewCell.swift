import Foundation
import UIKit
import PureLayout

class CardsViewCell: UICollectionViewCell {
    
    private var nameLabel: UILabel!
    private var cardNumberLabel: UILabel!
    private var cardTypeLabel: UILabel!
    
    private var card: Card!
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        createViews()
        customizeViews()
        defineViewLayout()

    }
    
    private func createViews() {
        nameLabel = UILabel()
        cardNumberLabel = UILabel()
        cardTypeLabel = UILabel()
        
    }
    
    private func customizeViews() {
        
        // New UIView needed to properly clip image because of rounded corners.
        let imageAndTextView = UIView()
        contentView.addSubview(imageAndTextView)
        imageAndTextView.frame = contentView.frame
        
        imageAndTextView.addSubview(nameLabel)
        imageAndTextView.addSubview(cardNumberLabel)
        imageAndTextView.addSubview(cardTypeLabel)
        imageAndTextView.backgroundColor = .white
        imageAndTextView.layer.cornerRadius = 15
        imageAndTextView.layer.masksToBounds = true

        
        nameLabel.adjustsFontSizeToFitWidth = true
        
        cardNumberLabel.textColor = .gray

        contentView.layer.cornerRadius = 15
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        
    }
    
    private func defineViewLayout() {

        nameLabel.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 8)
        nameLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -8)
        nameLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 10)
        nameLabel.autoSetDimension(.height, toSize: 20)

        
        cardNumberLabel.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 8)
        cardNumberLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -8)
        cardNumberLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 4)
    
        cardTypeLabel.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 10)
        cardTypeLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 10)
    }
    
    private func hideCardNumber(_ number: String) -> String {
        guard number.count == 16 else {
            return ""
        }
        
        let range = number.index(number.startIndex, offsetBy: 6)..<number.index(number.startIndex, offsetBy: 12)
        
        return number.replacingCharacters(in: range, with: String(repeating: "X", count: 6))
    }
    
    public func setCard(card: Card) {
        self.card = card
        nameLabel.attributedText = NSMutableAttributedString().bold(card.cardName, fontSize: 24)
        cardNumberLabel.attributedText = NSMutableAttributedString().normal(hideCardNumber(card.cardNumber), fontSize: 14)
        cardTypeLabel.attributedText = NSMutableAttributedString().normal(card.cardType, fontSize: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
