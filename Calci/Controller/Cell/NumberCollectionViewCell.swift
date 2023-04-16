//
//  OperationCollectionViewCell.swift
//  Calci
//
//  Created by Syed Wajahat Ali on 06/04/2023.
//

import UIKit

class NumberCollectionViewCell: UICollectionViewCell {
    
//    var operationCollectionViewModel: OperationCollectionViewModel?
    var operation: CalcButton?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = operation?.title
        label.textAlignment = .center
        label.font = UIDevice().screenType == .iPhones_6_6s_7_8 || UIDevice().screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus || UIDevice().screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus_Simulators  ? .systemFont(ofSize: 25, weight: .regular) : .systemFont(ofSize: 30, weight: .regular)
        return label
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(operation: CalcButton) {
        self.operation = operation
        
        self.backgroundColor = operation.backgroundColor
        switch operation {
        case .number, .plusminus, .decimal, .equals:
            titleLabel.textColor = .white
        case .clear:
            titleLabel.textColor = .orange
        case .parenthesis, .percentage, .divide, .multiply, .substract, .addition:
            titleLabel.textColor = UIColor().hexStringToUIColor(hex: "#93D15C")
        }
        
        setupUI()
    }
    
    func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.cornerRadius = self.frame.size.width/2

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
}
