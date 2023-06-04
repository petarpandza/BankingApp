import Foundation
import UIKit
import PureLayout

class CardsViewController: UIViewController {
    
    var coordinator: AppCoordinator!
    
    private var cardsLabel: UILabel!
    
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
        parent?.title = "Cards"
    }
    
    private func createViews() {
        cardsLabel = UILabel()
        
        layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width*0.85, height: view.frame.width*0.4)
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.addSubview(cardsLabel)
        view.addSubview(collectionView)
    }
    
    private func customizeViews() {
        view.backgroundColor = .white
        
        cardsLabel.attributedText = NSMutableAttributedString().bold("Your Cards", fontSize: 32)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func defineViewLayout() {
            
        collectionView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0))
        
        cardsLabel.autoPinEdge(.bottom, to: .top, of: collectionView, withOffset: -30)
        cardsLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 30)
        
    }
    
    private func registerViewCells() {
        collectionView.register(CardsViewCell.self, forCellWithReuseIdentifier: "card")
    }
}

extension CardsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var card: Card?
        var index = indexPath.row
        
        for account in Account.example() {
            if (account.cards.count < index) {
                index -= account.cards.count
            } else {
                card = account.cards[index]
                break
            }
        }
        
        guard let card else {
            return
        }
        
        coordinator.cardDetails(card: card)
    }
}

extension CardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        for account in Account.example() {
            count += account.cards.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "card", for: indexPath) as? CardsViewCell else {
            fatalError("Unable to dequeue cell")
        }

        var index = indexPath.row
        var card: Card?
        
        for account in Account.example() {
            if (account.cards.count < index) {
                index -= account.cards.count
            } else {
                card = account.cards[index]
                break
            }
        }
        
        guard let card else {
            return cell
        }
        
        cell.setCard(card: card)
        
        return cell
    }
    
    
}

