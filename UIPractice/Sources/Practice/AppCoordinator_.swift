//
//  AppCoordinator_.swift
//  UIPractice
//
//  Created by 이숭인 on 5/31/24.
//

import UIKit

// App coordinator is the only one coordinator which will exist during app's life cycle
class AppCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    var type: CoordinatorType { .app }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
//        navigationController.setNavigationBarHidden(true, animated: true)
    }

    func start() {
        showLoginFlow()
    }
        
    func showLoginFlow() {
        let loginCoordinator = LoginCoordinator(navigationController)
        loginCoordinator.finishDelegate = self
        loginCoordinator.start()
        childCoordinators.append(loginCoordinator)
    }
    
    func showMainFlow() {
        // Implement Main (Tab bar) FLow
        let tabCoordinator = TabCoordinator.init(navigationController)
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
        
        switch childCoordinator.type {
        case .tab:
            navigationController.viewControllers.removeAll()
            
            showLoginFlow()
        case .login:
            navigationController.viewControllers.removeAll()
            
            showMainFlow()
        default:
            break
        }
    }
}
