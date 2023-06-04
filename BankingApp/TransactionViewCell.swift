import Foundation
import UIKit
import PureLayout

class TransactionViewCell: UICollectionViewCell {
    
    private var nameLabel: UILabel!
    private var dateLabel: UILabel!
    private var amountLabel: UILabel!
    
    private var transaction: Transaction!
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        createViews()
        customizeViews()
        defineViewLayout()

    }
    
    private func createViews() {
        nameLabel = UILabel()
        dateLabel = UILabel()
        amountLabel = UILabel()
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(amountLabel)
    }
    
    private func customizeViews() {
        
        contentView.layer.cornerRadius = 5

        nameLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    private func defineViewLayout() {

        nameLabel.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 8)
        nameLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -8)
        nameLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 4)
        nameLabel.autoSetDimension(.height, toSize: 20)

        
        dateLabel.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 8)
        dateLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -8)
        dateLabel.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: -4)
    
        amountLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -8)
        amountLabel.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: -4)
    }
    
    public func setTransaction(transaction: Transaction) {
        self.transaction = transaction
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy."
        
        nameLabel.attributedText = NSMutableAttributedString().bold(transaction.name, fontSize: 12)
        dateLabel.attributedText = NSMutableAttributedString().normal(dateFormatter.string(from: transaction.date), fontSize: 12)
        amountLabel.attributedText = NSMutableAttributedString().normal(String(format: "%.2f EUR", transaction.amount), fontSize: 22)
        
        if (transaction.amount < 0) {
            contentView.backgroundColor = UIColor(red: 0.9686, green: 0.7922, blue: 0.7922, alpha: 1.0)
        } else {
            contentView.backgroundColor = UIColor(red: 0.7373, green: 0.9882, blue: 0.7098, alpha: 1.0)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
