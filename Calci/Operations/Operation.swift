//
//  Operation.swift
//  Calci
//
//  Created by Syed Wajahat Ali on 08/05/2023.
//

import Foundation

class Operation {
    
    init() { }
    
    func parenthesis(cursorPosition: Int, completeTextFieldValue: String) -> String {
        let completeTextFieldTextLength: Int = 0
        var openParenthesis = 0
        var closeParenthesis = 0
        var result:String
        
        for index in 0...cursorPosition {
            if completeTextFieldValue.characterExists(at: index, character: "(") {
                openParenthesis += 1
            }
            
            if completeTextFieldValue.characterExists(at: index, character: ")") {
                closeParenthesis += 1
            }
        }
               
        if (
            !(completeTextFieldTextLength < cursorPosition && completeTextFieldValue.contains("×÷+-^"))
            &&
            (closeParenthesis == openParenthesis || completeTextFieldValue.characterExists(at: cursorPosition - 1, character: "(") || completeTextFieldValue.contains("×÷+-^"))
        ) {
            result = updateDisplay(cursorPosition: cursorPosition, textValue: completeTextFieldValue, value: "(")
        } else {
            result = updateDisplay(cursorPosition: cursorPosition, textValue: completeTextFieldValue, value: ")")
        }
        
        return result
    }
    
    private func updateDisplay(cursorPosition: Int, textValue: String, value: String) -> String {
        let leftValue = textValue.prefix(cursorPosition)
        let rightValue = textValue.suffix(textValue.count - cursorPosition)

        let newValue = leftValue + value + rightValue
        let character = String(newValue).extractCharacter(character: Character(value))
        return character?.description ?? ""
    }
   
    func plusMinus(textValue: String) -> String {
        if textValue != "" && textValue.subStirng(from: 0, to: 2).contains("(-") {
            return ""
        } else {
            return "(-\(textValue)"
        }
    }
}
