import UIKit

class TabViewController: UITabBarController {
    
    private var coordinator: AppCoordinator!
    
    init(_ coordinator: AppCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let accountsVC = AccountsViewController(coordinator)
        accountsVC.tabBarItem = UITabBarItem(title: "Accounts", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        let cardsVC = CardsViewController(coordinator)
        cardsVC.tabBarItem = UITabBarItem(title: "Cards", image: UIImage(systemName: "creditcard"), selectedImage: UIImage(systemName: "creditcard.fill"))
        
        self.viewControllers = [accountsVC, cardsVC]
    }

    
    
}

