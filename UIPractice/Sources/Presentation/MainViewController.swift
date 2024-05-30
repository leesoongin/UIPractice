//
//  MainViewController.swift
//  UIPractice
//
//  Created by 이숭인 on 5/30/24.
//

import UIKit
import SnapKit
import Then
import Combine
import CombineCocoa

final class MainViewController: UIViewController {
    var cancellables = Set<AnyCancellable>()
    
    private let textField: UITextField = UITextField().then {
        $0.placeholder = "placeholder"
    }
    private let bottomButton: UIButton = UIButton().then {
        $0.setTitle("눌러주세요", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    private let bottomLayoutView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupConstraints()
        setFirstResponder()
        bindKeyboad()
        bindAction()
    }
    
    private func setupSubviews() {
        view.addSubview(textField)
        view.addSubview(bottomButton)
        view.addSubview(bottomLayoutView)
    }
    
    private func setupConstraints() {
        textField.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        bottomButton.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(32)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(bottomLayoutView.snp.top).offset(-32)
        }
        
        bottomLayoutView.snp.makeConstraints { make in
            make.height.equalTo(0)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func bindKeyboad() {
        Publishers.CombineLatest(KeyboardManager.shared.keyboardHeightPublisher,
                                 CombineKeyboard.shared.height)
        .receive(on: DispatchQueue.main)
        .sink { [weak self] _, height in
            self?.updateBottomLayoutHeight(to: height)
        }
        .store(in: &cancellables)
        
    }
    
    private func bindAction() {
        bottomButton.tap
            .sink { [weak self] _ in
                let secondVC = UIViewController()
                secondVC.title = "secondVC"
                secondVC.view.backgroundColor = .brown
                self?.navigationController?.pushViewController(secondVC, animated: true)
            }
            .store(in: &cancellables)
    }
    
    private func updateBottomLayoutHeight(to height: CGFloat) {
        bottomLayoutView.snp.updateConstraints { make in
            make.height.equalTo(min(view.bounds.height, height))
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.beginFromCurrentState]) {
            self.view.layoutIfNeeded()
        }
    }
}

extension MainViewController {
    private func setFirstResponder() {
        textField.becomeFirstResponder()
    }
}

extension UIControl {
    var tap: AnyPublisher<Void, Never> {
        controlEventPublisher(for: .touchUpInside)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func controlEventPublisher(for events: UIControl.Event) -> AnyPublisher<Void, Never> {
        Publishers.ControlEvent(control: self, events: events)
            .eraseToAnyPublisher()
    }
}
