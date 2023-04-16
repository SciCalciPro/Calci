//
//  CalcButtons.swift
//  Calci
//
//  Created by Syed Wajahat Ali on 07/04/2023.
//

import Foundation
import UIKit

enum CalcButton {
    case clear
    case parenthesis
    case percentage
    case divide
    case multiply
    case substract
    case addition
    case equals
    case plusminus
    case decimal
    case number(Int)
    
    init(calcButton: CalcButton) {
        switch calcButton {
        case .clear, .parenthesis, .percentage, .divide, .multiply, .substract, .addition, .equals, .plusminus, .decimal:
            self = calcButton
        case .number(let int):
            if int.description.count == 1 {
                self = calcButton
            } else {
                fatalError("int.number description count was not 1 when init")
            }
        }
    }
}

extension CalcButton {
    var title: String {
        switch self {
        case .clear:
            return "C"
        case .parenthesis:
            return "( )"
        case .percentage:
            return "%"
        case .divide:
            return "÷"
        case .multiply:
            return "×"
        case .substract:
            return "-"
        case .addition:
            return "+"
        case .equals:
            return "="
        case .number(let num):
            return num.description
        case .plusminus:
            return "+/-"
        case .decimal:
            return "."
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .clear, .parenthesis, .percentage, .divide, .multiply, .substract, .addition, .number, .plusminus, .decimal:
            return UIColor().hexStringToUIColor(hex: "#171717", alpha: 0.8)
        case .equals:
            return UIColor().hexStringToUIColor(hex: "#427E03", alpha: 0.9)
        }
    }
}
