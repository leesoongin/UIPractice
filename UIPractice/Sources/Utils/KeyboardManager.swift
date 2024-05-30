//
//  KeyboardManager.swift
//  UIPractice
//
//  Created by 이숭인 on 5/30/24.
//

import UIKit
import Combine

final class KeyboardManager {
    static let shared = KeyboardManager()
    
    private var cancellables = Set<AnyCancellable>()
    
    // keyboard height
    private let keyboardHeightSubject = CurrentValueSubject<CGFloat, Never>(.zero)
    var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        keyboardHeightSubject.eraseToAnyPublisher()
    }
    var currentKeyboardHeight: CGFloat { keyboardHeightSubject.value }
    
    // first responder
    private let firstResponderSubject = CurrentValueSubject<UIView?, Never>(nil)
    var firstResponderPublisher: AnyPublisher<UIView?, Never> {
        firstResponderSubject.eraseToAnyPublisher()
    }
    var currentFirstResponder: UIView? { firstResponderSubject.value }
    
    private init() {
        bindKeyboard()
        bindTextInputEvents()
    }
    
    private func bindKeyboard() {
        CombineKeyboard.shared.height
            .sink { [weak self] height in
                self?.keyboardHeightSubject.send(height)
            }
            .store(in: &cancellables)
    }
    
    private func bindTextInputEvents() {
        let textInputViewEvents = [
            NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification),
            NotificationCenter.default.publisher(for: UITextField.textDidEndEditingNotification),
            NotificationCenter.default.publisher(for: UITextView.textDidBeginEditingNotification),
            NotificationCenter.default.publisher(for: UITextView.textDidEndEditingNotification)
        ]
        
        Publishers.MergeMany(textInputViewEvents)
            .sink { [weak self] notifications in
                guard let input = notifications.object as? UIView else { return }
                
                if input.isFirstResponder {
                    self?.firstResponderSubject.send(input)
                } else {
                    self?.firstResponderSubject.send(nil)
                }
            }
            .store(in: &cancellables)
    }
}
