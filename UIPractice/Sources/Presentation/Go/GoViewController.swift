//
//  GoViewController.swift
//  UIPractice
//
//  Created by 이숭인 on 5/31/24.
//

import UIKit

final class GoViewController: UIViewController {
    var viewModel: GoViewModel
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        
        return button
    }()
    
    init(_ viewModel: GoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(loginButton)

        loginButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)
    }
    
    deinit {
        print("GoViewController deinit")
    }

    @objc private func didTapLoginButton(_ sender: Any) {
        viewModel.didTapBottomButton()
    }
}

final class GoViewModel {
    weak var coordinator: TabCoordinator?
    
    func didTapBottomButton() {
        coordinator?.finish()
    }
}
