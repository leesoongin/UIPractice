//
//  LoginCoordinator.swift
//  UIPractice
//
//  Created by 이숭인 on 5/31/24.
//

import UIKit

class LoginCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .login }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        showLoginViewController()
    }
    
    deinit {
        print("LoginCoordinator deinit")
    }
    
    func showLoginViewController() {
        let viewModel = LoginViewModel()
        viewModel.coordinator = self
        let loginVC: LoginViewController = LoginViewController(viewModel)
        
        navigationController.pushViewController(loginVC, animated: true)
    }
}
