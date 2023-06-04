import Foundation
import UIKit
import PureLayout

class AccountsViewCell: UICollectionViewCell {
    
    private var nameLabel: UILabel!
    private var idLabel: UILabel!
    private var amountLabel: UILabel!
    
    private var account: Account!
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        createViews()
        customizeViews()
        defineViewLayout()

    }
    
    private func createViews() {
        nameLabel = UILabel()
        idLabel = UILabel()
        amountLabel = UILabel()
        
    }
    
    private func customizeViews() {
        
        // New UIView needed to properly clip image because of rounded corners.
        let imageAndTextView = UIView()
        contentView.addSubview(imageAndTextView)
        imageAndTextView.frame = contentView.frame
        
        imageAndTextView.addSubview(nameLabel)
        imageAndTextView.addSubview(idLabel)
        imageAndTextView.addSubview(amountLabel)
        imageAndTextView.backgroundColor = .white
        imageAndTextView.layer.cornerRadius = 15
        imageAndTextView.layer.masksToBounds = true

        
        nameLabel.adjustsFontSizeToFitWidth = true
        
        idLabel.lineBreakMode = .byTruncatingTail
        idLabel.numberOfLines = 5
        idLabel.textColor = .gray

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

        
        idLabel.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 8)
        idLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -8)
        idLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 4)
    
        amountLabel.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 10)
        amountLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 10)
    }
    
    public func setAccount(account: Account) {
        self.account = account
        nameLabel.attributedText = NSMutableAttributedString().bold(account.accountName, fontSize: 24)
        idLabel.attributedText = NSMutableAttributedString().normal(account.accountId, fontSize: 14)
        amountLabel.attributedText = NSMutableAttributedString().normal(String(format: "%.2f EUR", account.balance), fontSize: 22)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
