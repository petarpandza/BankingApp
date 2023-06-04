import Foundation
import UIKit

protocol AppCoordinatorProtocol {
    
    func loginSuccessful()
    
    func accountDetails(account: Account)
    
    func cardDetails(card: Card)
    
}

class AppCoordinator: AppCoordinatorProtocol {

    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func loginSuccessful() {
        navigationController.viewControllers = [TabViewController(self)]
    }
    
    func accountDetails(account: Account) {
        navigationController.pushViewController(AccountDetailsViewController(self, account: account), animated: true)
    }
    
    func cardDetails(card: Card) {
        navigationController.pushViewController(CardDetailsViewController(self, card: card), animated: true)
    }
}
