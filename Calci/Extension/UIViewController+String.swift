//
//  UIViewController+String.swift
//  Calci
//
//  Created by Syed Wajahat Ali on 15/05/2023.
//

import Foundation

extension String {
    func extractCharacter(character: Character) -> Character? {
        if let index = self.firstIndex(of: character) {
            return self[index]
        }
        
        return nil
    }
    
    func characterExists(at cursorPosition: Int, character: Character) -> Bool {
        guard cursorPosition >= 0 && cursorPosition < count else {
            return false
        }
        let position = self.index(startIndex, offsetBy: cursorPosition)
        return self[position] == character
    }
}
