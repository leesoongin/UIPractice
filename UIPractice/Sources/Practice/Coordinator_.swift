//
//  Coordinator_.swift
//  UIPractice
//
//  Created by 이숭인 on 5/31/24.
//

import UIKit

// MARK: - CoordinatorOutput

/// Delegate protocol helping parent Coordinator know when its child is ready to be finished.
protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

// MARK: - CoordinatorType

/// Using this structure we can define what type of flow we can use in-app.
enum CoordinatorType {
    case app, login, tab
}

//MARK: - Coordinator_
protocol Coordinator: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var type: CoordinatorType { get }
    
    func start()
    func finish()
    
    init(_ navigationController: UINavigationController)
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}
