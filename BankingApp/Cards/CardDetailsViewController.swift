import Foundation
import UIKit
import PureLayout

class CardDetailsViewController: UIViewController {
    
    var coordinator: AppCoordinator!
    
    private var card: Card!
    
    private var cardContainerView: UIView!
    private var cardNumberLabel: UILabel!
    private var cardExpiryDateLabel: UILabel!
    private var cardCVVLabel: UILabel!
    
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    
    init(_ coordinator: AppCoordinator, card: Card) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        self.card = card
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
        parent?.parent?.title = card.cardName
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
        
        view.addSubview(cardContainerView)
        cardContainerView.addSubview(cardNumberLabel)
        cardContainerView.addSubview(cardExpiryDateLabel)
        cardContainerView.addSubview(cardCVVLabel)
    }
    
    private func customizeViews() {
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cardContainerView.backgroundColor = .white
        cardContainerView.layer.borderWidth = 1
        cardContainerView.layer.borderColor = UIColor.black.cgColor
        cardContainerView.layer.cornerRadius = 20
        
        cardNumberLabel.attributedText = NSMutableAttributedString().normal(card.cardNumber, fontSize: 20)
        cardExpiryDateLabel.attributedText = NSMutableAttributedString().normal(card.expiryDate, fontSize: 20)
        cardCVVLabel.attributedText = NSMutableAttributedString().normal(card.CVV, fontSize: 20)
        
    }
    
    private func defineViewLayout() {
            
        
        
        cardContainerView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 10)
        cardContainerView.autoAlignAxis(toSuperviewAxis: .vertical)
        var cardWidth = view.frame.width*0.9
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
        cardCVVLabel.autoPinEdge(.leading, to: .trailing, of: cardExpiryDateLabel, withOffset: 30)
        
    }
    
    private func registerViewCells() {
        collectionView.register(TransactionViewCell.self, forCellWithReuseIdentifier: "card details")
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



