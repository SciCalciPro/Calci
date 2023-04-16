//
//  RootCoordinator.swift
//  Calci
//
//  Created by Syed Wajahat Ali on 05/04/2023.
//

import Foundation
import UIKit

protocol Coordinator {
    var coordinator: [Coordinator] {get set}
    func start()
}

class RootCoordinator: Coordinator {
    var coordinator: [Coordinator] = []
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        let calculatorCoordinator = CalculatorCoordinator(navigationController: navigationController)
        coordinator.append(calculatorCoordinator)
        calculatorCoordinator.start()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
