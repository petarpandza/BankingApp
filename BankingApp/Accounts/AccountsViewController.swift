import Foundation
import UIKit
import PureLayout

class AccountsViewController: UIViewController {
    
    var coordinator: AppCoordinator!
    
    private var accountsLabel: UILabel!
    
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    
    init(_ coordinator: AppCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
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
        parent?.title = "Accounts"
    }
    
    private func createViews() {
        accountsLabel = UILabel()
        
        layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width*0.85, height: view.frame.width*0.4)
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.addSubview(accountsLabel)
        view.addSubview(collectionView)
    }
    
    private func customizeViews() {
        view.backgroundColor = .white
        
        accountsLabel.attributedText = NSMutableAttributedString().bold("Your Accounts", fontSize: 32)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func defineViewLayout() {
            
        collectionView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0))
        
        accountsLabel.autoPinEdge(.bottom, to: .top, of: collectionView, withOffset: -30)
        accountsLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 30)
        
    }
    
    private func registerViewCells() {
        collectionView.register(AccountsViewCell.self, forCellWithReuseIdentifier: "account")
    }
}

extension AccountsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        coordinator.accountDetails(account: Account.Example()[indexPath.row])
        
    }
}

extension AccountsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Account.Example().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "account", for: indexPath) as? AccountsViewCell else {
            fatalError("Unable to dequeue cell")
        }

        cell.setAccount(account: Account.Example()[indexPath.row])
        
        return cell
    }
    
    
}

