import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController!
    var coordinator: AppCoordinator!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let vc = LoginViewController()
        navigationController = UINavigationController(rootViewController: vc)
        coordinator = AppCoordinator(navigationController: navigationController)
        vc.coordinator = coordinator
        //navigationController.navigationBar.backgroundColor = .white
        

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        let vc = LoginViewController()
        vc.coordinator = coordinator
        navigationController.viewControllers = [vc]
    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

