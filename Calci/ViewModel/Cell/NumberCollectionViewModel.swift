//
//  NumberCollectionViewModel.swift
//  Calci
//
//  Created by Syed Wajahat Ali on 08/04/2023.
//

import Foundation
import Combine

class NumberCollectionViewModel {
    
    var numberButtonTapped = PassthroughSubject<CalcButton, Never>()
    var cancellable = Set<AnyCancellable>()
    
    var numbers:[CalcButton]?
    
    init() {
        
    }
    
    func didSelectItemAt(number: String) {
        switch number {
        case "C":
            numberButtonTapped.send(.clear)
        case "( )":
            numberButtonTapped.send(.parenthesis)
        case "%":
            numberButtonTapped.send(.percentage)
        case "+/-":
            numberButtonTapped.send(.plusminus)
        case ".":
            numberButtonTapped.send(.decimal)
        default:
            guard let intTypeCast = Int(number) else { return }
            numberButtonTapped.send(.number(intTypeCast))
        }
    }
}
