//
//  SteadyViewController.swift
//  UIPractice
//
//  Created by 이숭인 on 5/31/24.
//

import UIKit
import SnapKit
import Then
import Combine

final class SteadyViewController: UIViewController {
    var cancellables = Set<AnyCancellable>()
    var viewModel: SteadyViewModel
    
    private let expandableView: UIView = UIView().then {
        $0.backgroundColor = .green
    }
    
    private let foldButton = UIButton().then {
        $0.backgroundColor = .systemBlue
        $0.setTitle("펼치기", for: .normal)
        $0.setTitle("접기", for: .selected)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 8.0
    }
 
    init(_ viewModel: SteadyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [expandableView, foldButton].forEach { view.addSubview($0) }

        expandableView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(120)
        }
        
        foldButton.snp.makeConstraints { make in
            make.top.equalTo(expandableView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(32)
        }
        
        bindAction()
    }
    
    private func bindAction() {
        foldButton.tap
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.foldButton.isSelected.toggle()
            }
            .store(in: &cancellables)
        
        foldButton.publisher(for: \.isSelected)
            .dropFirst()
            .sink { [weak self] isSelected in
                print("isSelected > \(isSelected)")
                let isFold = !isSelected
                self?.updateExpandableView(isFold: isFold)
            }
            .store(in: &cancellables)
    }
    
    deinit {
        print("SteadyViewController deinit")
    }

    private func updateExpandableView(isFold: Bool) {
        expandableView.snp.updateConstraints { make in
            make.height.equalTo(isFold ? 120 : 300)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.beginFromCurrentState]) {
            self.view.layoutIfNeeded()
        }
    }
}

final class SteadyViewModel {
    weak var coordinator: TabCoordinator?
    
    func didTapBottomButton() {
        coordinator?.selectPage(.go)
    }
}
