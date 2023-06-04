import Foundation
import UIKit
import PureLayout

class AccountDetailsViewController: UIViewController {
    
    var coordinator: AppCoordinator!
    
    private var account: Account!
    
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    
    init(_ coordinator: AppCoordinator, account: Account) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        self.account = account
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
    
    override func viewWillAppear(_ animated: Bool) {
        parent?.parent?.title = account.accountName
    }
    
    private func createViews() {
        
        layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width*0.95, height: view.frame.width*0.2)
        layout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.addSubview(collectionView)
    }
    
    private func customizeViews() {
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func defineViewLayout() {
            
        collectionView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0))

        
    }
    
    private func registerViewCells() {
        collectionView.register(TransactionViewCell.self, forCellWithReuseIdentifier: "account details")
    }
}

extension AccountDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
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


