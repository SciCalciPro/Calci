//
//  CalculatorCoordinator.swift
//  Calci
//
//  Created by Syed Wajahat Ali on 05/04/2023.
//

import Foundation
import UIKit

class CalculatorCoordinator: Coordinator {
    var coordinator: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func start() {
        let calculatorViewController = CalculatorViewController()
        let operations = Operation()
        let calculatorViewModel = CalculatorViewModel(operations: operations)
        calculatorViewController.calculatorViewModel = calculatorViewModel
        navigationController?.setViewControllers([calculatorViewController], animated: true)
    }
}
