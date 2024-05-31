//
//  LoginViewModel.swift
//  UIPractice
//
//  Created by 이숭인 on 5/31/24.
//

import Foundation
import Combine

final class LoginViewModel {
    weak var coordinator: LoginCoordinator?
    
    func didTapBottomButton() {
        coordinator?.finish()
    }
}
