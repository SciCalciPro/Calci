//
//  CalculatorViewModel.swift
//  Calci
//
//  Created by Syed Wajahat Ali on 05/04/2023.
//

import Foundation

class CalculatorViewModel {
    let operations:[CalcButton] = [
        .divide, .multiply, .substract, .addition, .equals
    ]
    
    let numbers:[CalcButton] = [
        .clear, .parenthesis, .percentage,
        .number(7), .number(8), .number(9),
        .number(4), .number(5), .number(6),
        .number(1), .number(2), .number(3),
        .plusminus, .number(0), .decimal
    ]
}
