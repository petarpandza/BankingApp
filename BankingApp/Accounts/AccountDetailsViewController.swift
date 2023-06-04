import Foundation
import UIKit
import PureLayout

class AccountDetailsViewController: UIViewController {
    
    var coordinator: AppCoordinator!
    
    private var account: Account!
    
    private var accountNameLabel: UILabel!
    private var accountIDLabel: UILabel!
    private var accountBalanceLabel: UILabel!
    
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    
    init(_ coordinator: AppCoordinator, account: Account) {
        self.coordinator = coordinator
        self.account = account
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
        
        accountNameLabel = UILabel()
        accountIDLabel = UILabel()
        accountBalanceLabel = UILabel()
        
        view.addSubview(accountNameLabel)
        view.addSubview(accountIDLabel)
        view.addSubview(accountBalanceLabel)
        
        layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width*0.95, height: view.frame.width*0.2)
        layout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.addSubview(collectionView)
    }
    
    private func customizeViews() {
        view.backgroundColor = .white
        self.title = account.accountName
        
        accountNameLabel.attributedText = NSMutableAttributedString().bold(account.accountName, fontSize: 26)
        accountIDLabel.attributedText = NSMutableAttributedString().normal(account.accountId, fontSize: 23)
        accountBalanceLabel.attributedText = NSMutableAttributedString().bold(String(format: "%.2f EUR", account.balance), fontSize: 30)
        
        accountIDLabel.textColor = .gray
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func defineViewLayout() {
            
        accountNameLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 15)
        accountNameLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 15)
        
        accountIDLabel.autoPinEdge(.leading, to: .leading, of: accountNameLabel)
        accountIDLabel.autoPinEdge(.top, to: .bottom, of: accountNameLabel)
        
        accountBalanceLabel.autoPinEdge(.leading, to: .leading, of: accountNameLabel)
        accountBalanceLabel.autoPinEdge(.top, to: .bottom, of: accountIDLabel)
        
        
        collectionView.autoPinEdge(.top, to: .bottom, of: accountBalanceLabel, withOffset: 50)
        
        collectionView.autoPinEdge(toSuperviewSafeArea: .leading)
        collectionView.autoPinEdge(toSuperviewSafeArea: .trailing)
        collectionView.autoPinEdge(toSuperviewSafeArea: .bottom)


    }
    
    private func registerViewCells() {
        collectionView.register(TransactionViewCell.self, forCellWithReuseIdentifier: "account details")
    }
}

extension AccountDetailsViewController: UICollectionViewDelegate {
}

extension AccountDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        for card in account.cards {
            count += card.transactions.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "account details", for: indexPath) as? TransactionViewCell else {
            fatalError("Unable to dequeue cell")
        }
        
        var index = indexPath.row
        var transaction: Transaction?
        
        for card in account.cards {
            if (card.transactions.count < index+1) {
                index -= card.transactions.count
            } else {
                transaction = card.transactions[index]
                break
            }
        }

        guard let transaction else {
            return cell
        }
        
        cell.setTransaction(transaction: transaction)
        
        return cell
    }
    
    
}


