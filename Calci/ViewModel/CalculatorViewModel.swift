//
//  CalculatorViewModel.swift
//  Calci
//
//  Created by Syed Wajahat Ali on 05/04/2023.
//

import Foundation
import Combine

protocol CalculatorViewModelDelegate {
    func didUpdateNumberViewValue()
    func didUpdateOperationViewValue()
}

enum Input {
    case viewDidLoad
    case numberButtonStatus(button: ButtonSelection)
    case operationButtonStatus(button: CalcButton)
    case update(result: Int)
}

enum Output {
    case setNumber(numbers: [CalcButton])
    case setOperators(operations: [CalcButton])
}

class CalculatorViewModel {

    private let output = PassthroughSubject<Output, Never>()
    private var cancellable = Set<AnyCancellable>()
    
//    @Published private var operations:[CalcButton] = []
//    @Published private var numbers:[CalcButton] = []
    var operations: Operation?
    
    init(operations: Operation) {
        self.operations = operations
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] inputOperation in
            switch inputOperation {
            case .viewDidLoad:
                let numbers:[CalcButton] = [
                    .clear, .parenthesis, .percentage,
                    .number(7), .number(8), .number(9),
                    .number(4), .number(5), .number(6),
                    .number(1), .number(2), .number(3),
                    .plusminus, .number(0), .decimal
                ]
                
                let operations:[CalcButton] = [
                    .divide, .multiply, .substract, .addition, .equals
                ]
                
                self?.output.send(.setNumber(numbers: numbers))
                self?.output.send(.setOperators(operations: operations))
            case .numberButtonStatus(button: let numberButton):
                self?.didNumberButtonTapped(buttonSelection: numberButton)
                break
            case .operationButtonStatus(button: _):
                break
            case .update(result: _):
                break
            }
        }.store(in: &cancellable)
        
        
        return output.eraseToAnyPublisher()
    }
    
    func didNumberButtonTapped(buttonSelection: ButtonSelection) {
        switch buttonSelection {
        case .clearSelected:
            print("C")
        case .parenthesisSelected:
            self.operations?.parenthesis()
        case .percentageSelected:
            print("%")
        case .numberSelected(let selectedNumber):
            print("\(selectedNumber)")
        case .decimalSelected:
            print(".")
        case .plusMinusSelected:
            print("(+-)")
        }
    }
}
