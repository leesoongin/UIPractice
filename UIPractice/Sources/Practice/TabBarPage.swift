//
//  TabBarPage.swift
//  UIPractice
//
//  Created by 이숭인 on 5/31/24.
//

import Foundation

enum TabBarPage {
    case ready
    case steady
    case go

    init?(index: Int) {
        switch index {
        case 0:
            self = .ready
        case 1:
            self = .steady
        case 2:
            self = .go
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .ready:
            return "Ready"
        case .steady:
            return "Steady"
        case .go:
            return "Go"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .ready:
            return 0
        case .steady:
            return 1
        case .go:
            return 2
        }
    }

    // Add tab icon value
    
    // Add tab icon selected / deselected color
    
    // etc
}
