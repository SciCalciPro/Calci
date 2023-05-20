//
//  File.swift
//  Calci
//
//  Created by Syed Wajahat Ali on 07/04/2023.
//

import Foundation
import Combine

class OperationCollectionViewModel {
    
    var operationButtonTapped = PassthroughSubject<CalcButton, Never>()
    var cancellable = Set<AnyCancellable>()

    var operations:[CalcButton]?
    
    init() {
        
    }
    
    func didSelectItemAt(number: String) {
        switch number {
        case "C":
            operationButtonTapped.send(.clear)
        case "( )":
            operationButtonTapped.send(.parenthesis)
        case "%":
            operationButtonTapped.send(.percentage)
        case "+/-":
            operationButtonTapped.send(.plusminus)
        case ".":
            operationButtonTapped.send(.decimal)
        default:
            guard let intTypeCast = Int(number) else { return }
            operationButtonTapped.send(.number(intTypeCast))
        }
    }
}
