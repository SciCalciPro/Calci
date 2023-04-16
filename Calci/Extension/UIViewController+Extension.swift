//
//  UIViewController+Extension.swift
//  Calci
//
//  Created by Syed Wajahat Ali on 05/04/2023.
//

import Foundation
import UIKit

extension UIViewController {
    func makeButton(title: String, tag: Int) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = button.layer.frame.size.height/2
        button.clipsToBounds = true
        button.setTitle(title, for: .normal)
        button.tag = tag
        
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
