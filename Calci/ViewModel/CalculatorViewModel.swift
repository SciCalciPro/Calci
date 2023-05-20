//
//  CalculatorViewModel.swift
//  Calci
//
//  Created by Syed Wajahat Ali on 05/04/2023.
//

import Foundation
import UIKit
import Combine

protocol CalculatorViewModelDelegate {
    func didUpdateNumberViewValue()
    func didUpdateOperationViewValue()
}

enum Input {
    case viewDidLoad
    case numberButtonStatus(button: CalcButton)
    case operationButtonStatus(button: CalcButton)
    case update(result: Int)
}

enum Output {
    case setNumber(numbers: [CalcButton])
    case setOperators(operations: [CalcButton])
    case updateText(value: String)
}

class CalculatorViewModel {

    private let output = PassthroughSubject<Output, Never>()
    private var cancellable = Set<AnyCancellable>()
    
    var textFieldValue = CurrentValueSubject<String, Never>("")
    var textFieldCursorPosition = PassthroughSubject<Int, Never>()
    var operations: Operation?
    
    private var completeTextFieldValue: String = ""
    private var cursorPosition: Int = 0
    
    init(operations: Operation) {
        self.operations = operations
        
        textFieldCursorPosition.sink { value in
            print("value of current cursor position => \(value)")
            self.cursorPosition = value
        }.store(in: &cancellable)
        
        textFieldValue.sink(receiveValue: { [unowned self] textFieldValue in
            completeTextFieldValue = textFieldValue
        }).store(in: &cancellable)

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
                self?.didNumberButtonTapped(calcButton: numberButton)
            case .operationButtonStatus(button: _):
                break
            case .update(result: let value):
                print(value)
            }
        }.store(in: &cancellable)
        
        
        return output.eraseToAnyPublisher()
    }
    
    fileprivate func didNumberButtonTapped(calcButton: CalcButton) {
        var value: String = ""
        
        switch calcButton {
        case .clear:
            value = "C"
        case .parenthesis:
            if let parenthesis = self.operations?.parenthesis(cursorPosition: cursorPosition, completeTextFieldValue: completeTextFieldValue) {
                value = parenthesis
            }
        case .percentage:
            value="%"
        case .number(let selectedNumber):
            value="\(String(selectedNumber))"
        case .decimal:
            value="."
        case .plusminus:
            if let plusMinusOperator = self.operations?.plusMinus(textValue: completeTextFieldValue) {
                value = plusMinusOperator
            }
        case .divide:
            break
        case .multiply:
            break
        case .substract:
            break
        case .addition:
            break
        case .equals:
            break
        }
        
        self.output.send(.updateText(value: value))
    }
}
