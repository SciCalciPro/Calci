//
//  File.swift
//  Calci
//
//  Created by Syed Wajahat Ali on 06/04/2023.
//

import Foundation
import UIKit

protocol InstantiateNib {
    static func nibName() -> String
}

extension InstantiateNib {
    static func nibName() -> String {
        return String(describing: self)
    }
}

extension InstantiateNib where Self: UIView {
    static func instantiateNib() -> Self {
        let bundle = Bundle(for: self)
        let nib = bundle.loadNibNamed(nibName(), owner: self)
        return nib?.first as! Self 
    }
}
