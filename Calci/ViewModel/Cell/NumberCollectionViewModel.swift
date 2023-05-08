//
//  NumberCollectionViewModel.swift
//  Calci
//
//  Created by Syed Wajahat Ali on 08/04/2023.
//

import Foundation
import Combine

enum ButtonSelection {
    case clearSelected
    case parenthesisSelected
    case percentageSelected
    case numberSelected(selectedNumber: Int)
    case decimalSelected
    case plusMinusSelected
}

class NumberCollectionViewModel {
    
    var operationButtonTapped = PassthroughSubject<ButtonSelection, Never>()
    var operationButtonPublisher: AnyPublisher<ButtonSelection, Never> {
        operationButtonTapped.eraseToAnyPublisher()
    }
    var cancellable = Set<AnyCancellable>()
    
    var numbers:[CalcButton]?
    
    init() {
        
    }
    
    func didSelectItemAt(number: String) {
        switch number {
        case "C":
            operationButtonTapped.send(.clearSelected)
        case "( )":
            operationButtonTapped.send(.parenthesisSelected)
        case "%":
            operationButtonTapped.send(.percentageSelected)
        case "+/-":
            operationButtonTapped.send(.plusMinusSelected)
        case ".":
            operationButtonTapped.send(.decimalSelected)
        default:
            guard let intTypeCast = Int(number) else { return }
            operationButtonTapped.send(.numberSelected(selectedNumber: intTypeCast))
        }
    }
}
