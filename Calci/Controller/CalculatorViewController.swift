//
//  CalculatorViewController.swift
//  Calci
//
//  Created by Syed Wajahat Ali on 05/04/2023.
//

import UIKit
import Combine

class CalculatorViewController: UIViewController, InstantiateNib {
    var calculatorViewModel: CalculatorViewModel?
    var items: [Any] = []
    var newText: String = ""
    
    private let output = PassthroughSubject<Input, Never>()
    private var cancellable = Set<AnyCancellable>()
    
    // MARK:- Result TextField
    fileprivate lazy var resultTextField: UITextField = {
        let resultTextField = UITextField()
        
        resultTextField.font = .systemFont(ofSize: 40.0)
        resultTextField.textColor = .white
        resultTextField.textAlignment = .right
        resultTextField.becomeFirstResponder()
        resultTextField.inputView = UIView()        
        resultTextField.translatesAutoresizingMaskIntoConstraints = false
        return resultTextField
    }()

    // MARK:- Result Label
    fileprivate lazy var labelResult: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .right
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [historyBtn, conversionBtn, scientificOperationBtn])
        
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 20.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    fileprivate lazy var historyBtn: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var conversionBtn: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var scientificOperationBtn: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var backBtn: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK:- Divider View
    fileprivate var dividerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor().hexStringToUIColor(hex: "#1c1c1c")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK:- NumberPad View
    fileprivate let numberPadWrapperView: UIView = {
        let view = UIView()

        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let operationView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let numberView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var operationCollectionViewLayout: UICollectionViewLayout = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        return collectionViewLayout
    }()
    
    fileprivate lazy var operationCollectionView: OperationCollectionView = {
        let operationCollectionView = OperationCollectionView(frame: CGRect.zero, collectionViewLayout: operationCollectionViewLayout)
        
        let operationCollectionViewModel = OperationCollectionViewModel()
        operationCollectionView.operationCollectionViewModel = operationCollectionViewModel
        operationCollectionViewModel.operationButtonTapped.sink { [weak self] operationSelection in
            self?.output.send(.numberButtonStatus(button: operationSelection))
        }.store(in: &operationCollectionViewModel.cancellable)
        operationCollectionView.backgroundColor = .black
        operationCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return operationCollectionView
    }()
    
    fileprivate lazy var numberCollectionViewLayout: UICollectionViewLayout = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        return collectionViewLayout
    }()
    
    fileprivate lazy var numberCollectionView: NumberCollectionView = {
        let numberCollectionView = NumberCollectionView(frame: CGRect.zero, collectionViewLayout: numberCollectionViewLayout)

        let numberCollectionViewViewModel = NumberCollectionViewModel()
        numberCollectionView.numberCollectionViewModel = numberCollectionViewViewModel
        numberCollectionViewViewModel.numberButtonTapped.sink { [weak self] buttonSelection in
            self?.output.send(.numberButtonStatus(button: buttonSelection))
        }.store(in: &numberCollectionViewViewModel.cancellable)
        numberCollectionView.backgroundColor = .black
        numberCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return numberCollectionView
    }()

    // MARK:- Option Button
    fileprivate lazy var optionView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        
        register()
        addToSubview()
        applyConstraints()
        
        addNibsToView()
        observe()
        
        output.send(.viewDidLoad)
    }
    
    private func register() {
    }
    
    private func addToSubview() {
        view.addSubview(numberPadWrapperView)
        numberPadWrapperView.addSubview(operationView)
        numberPadWrapperView.addSubview(numberView)
        
        view.addSubview(dividerView)
        
        view.addSubview(optionView)
        optionView.addSubview(stackView)
        stackView.addSubview(historyBtn)
        stackView.addSubview(conversionBtn)
        stackView.addSubview(scientificOperationBtn)
        optionView.addSubview(backBtn)

        view.addSubview(labelResult)
        view.addSubview(resultTextField)
    }
    
    private func applyConstraints() {
        
        NSLayoutConstraint.activate([
            numberPadWrapperView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.6),
            numberPadWrapperView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            numberPadWrapperView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            numberPadWrapperView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            operationView.widthAnchor.constraint(equalTo: self.numberPadWrapperView.widthAnchor, multiplier: 0.25),
            operationView.topAnchor.constraint(equalTo: self.numberPadWrapperView.topAnchor),
            operationView.trailingAnchor.constraint(equalTo: self.numberPadWrapperView.trailingAnchor),
            operationView.bottomAnchor.constraint(equalTo: self.numberPadWrapperView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            //numberView.widthAnchor.constraint(equalTo: self.wrapperView.widthAnchor, multiplier: 0.75),
            
            numberView.topAnchor.constraint(equalTo: self.numberPadWrapperView.topAnchor),
            numberView.leadingAnchor.constraint(equalTo: self.numberPadWrapperView.leadingAnchor),
            numberView.trailingAnchor.constraint(equalTo: self.operationView.leadingAnchor),
            numberView.bottomAnchor.constraint(equalTo: self.numberPadWrapperView.bottomAnchor),
        ])
        
        // Divider View
        NSLayoutConstraint.activate([
            dividerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            dividerView.bottomAnchor.constraint(equalTo: self.numberPadWrapperView.topAnchor),
            dividerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            dividerView.heightAnchor.constraint(equalToConstant: 3),
        ])
        
        // Option View
        NSLayoutConstraint.activate([
            optionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05),
            optionView.trailingAnchor.constraint(equalTo: self.dividerView.trailingAnchor),
            optionView.leadingAnchor.constraint(equalTo: self.dividerView.leadingAnchor),
            optionView.bottomAnchor.constraint(equalTo: self.dividerView.topAnchor, constant: -20)
        ])
        
        // Stack View
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05),
            stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            stackView.leadingAnchor.constraint(equalTo: self.dividerView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.dividerView.topAnchor, constant: -20)
        ])
        
        // Back Button
        NSLayoutConstraint.activate([
            backBtn.heightAnchor.constraint(equalTo: self.stackView.heightAnchor, multiplier: 1.0),
            backBtn.widthAnchor.constraint(equalToConstant: 40),
            backBtn.centerYAnchor.constraint(equalTo: self.stackView.centerYAnchor),
            backBtn.trailingAnchor.constraint(equalTo: self.optionView.trailingAnchor),

        ])
        
        // Result Label
        NSLayoutConstraint.activate([
            labelResult.widthAnchor.constraint(equalTo: self.optionView.widthAnchor),
            labelResult.heightAnchor.constraint(equalToConstant: 50),
            labelResult.bottomAnchor.constraint(equalTo: self.optionView.topAnchor, constant: -20),
            labelResult.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])

        // Result TextField
        NSLayoutConstraint.activate([
            resultTextField.heightAnchor.constraint(equalToConstant: 80),
            resultTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            resultTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            resultTextField.bottomAnchor.constraint(equalTo: self.labelResult.topAnchor, constant: -20)
        ])
    }
    
    private func addNibsToView() {
        operationView.addSubview(operationCollectionView)
        numberView.addSubview(numberCollectionView)
        
        NSLayoutConstraint.activate([
            operationCollectionView.leadingAnchor.constraint(equalTo: self.operationView.leadingAnchor),
            operationCollectionView.trailingAnchor.constraint(equalTo: self.operationView.trailingAnchor),
            operationCollectionView.bottomAnchor.constraint(equalTo: self.operationView.bottomAnchor),
            operationCollectionView.topAnchor.constraint(equalTo: self.operationView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            numberCollectionView.leadingAnchor.constraint(equalTo: self.numberView.leadingAnchor),
            numberCollectionView.trailingAnchor.constraint(equalTo: self.numberView.trailingAnchor),
            numberCollectionView.bottomAnchor.constraint(equalTo: self.numberView.bottomAnchor),
            numberCollectionView.topAnchor.constraint(equalTo: self.numberView.topAnchor)
        ])
    }
    
}

extension CalculatorViewController {
    private func observe() {
        calculatorViewModel?.transform(input: output.eraseToAnyPublisher()).sink(receiveValue: { [unowned self] result in
            switch result {
            case .setOperators(operations: let operationButton):
                self.operationCollectionView.operationCollectionViewModel?.operations = operationButton
            case .setNumber(numbers: let numberButton):
                self.numberCollectionView.numberCollectionViewModel?.numbers = numberButton
            case .updateText(value: let value):
                self.updateResultSet(value: value)
                self.textFieldDidEndEditing(self.resultTextField)
            }
        }).store(in: &cancellable)
    }
    
    private func updateResultSet(value: String) {
        if value == "C" {
            self.resultTextField.text = ""
        } else if value == "" || value.contains("(-") {
            if value == "" {
                let actualValue = resultTextField.text?.subStirng(from: 2, to: resultTextField.text?.count ?? 0)
                self.resultTextField.text = actualValue
            } else {
                self.resultTextField.text = value
            }
        } else {
            self.resultTextField.text?.append(value)
        }
    }
}

extension CalculatorViewController {
    private func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            calculatorViewModel?.textFieldValue.send(text)
        }
        if let selectedRange = textField.selectedTextRange {
            let cursorPosition = textField.offset(from: textField.beginningOfDocument, to: selectedRange.start)
            calculatorViewModel?.textFieldCursorPosition.send(cursorPosition)
        }
    }
}
