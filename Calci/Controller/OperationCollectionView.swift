//
//  OperationCollectionViewController.swift
//  Calci
//
//  Created by Syed Wajahat Ali on 06/04/2023.
//

import UIKit

private let reuseIdentifier = "OperationCollectionView"

class OperationCollectionView: UICollectionView {

    var operationCollectionViewModel: OperationCollectionViewModel?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    
        register()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func register() {
        self.delegate = self
        self.dataSource = self
        self.register(NumberCollectionViewCell.self, forCellWithReuseIdentifier: "NumberCollectionViewCell")
    }
}

extension OperationCollectionView {
    func configureOperationCell(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: "NumberCollectionViewCell", for: indexPath) as? NumberCollectionViewCell else { return UICollectionViewCell() }
        
        if let operation = operationCollectionViewModel?.operations?[indexPath.row] {
            cell.configure(operation: operation)
        }
        
        return cell
    }
}

extension OperationCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        operationCollectionViewModel?.operations?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return configureOperationCell(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let leftRightPadding = collectionView.frame.width * 0.13
//        let interSpacing = collectionView.frame.width * 0.01
//
//        let cellWidth = (collectionView.frame.width - (2 * leftRightPadding) - (2 * interSpacing))
//        return .init(width: cellWidth, height: cellWidth)
        
        switch UIDevice().screenType {
        case .iPhones_6_6s_7_8, .iPhones_6Plus_6sPlus_7Plus_8Plus, .iPhones_6Plus_6sPlus_7Plus_8Plus_Simulators:
            let leftRightPadding = collectionView.frame.width * 0.2
            let interSpacing = collectionView.frame.width * 0.001
            
            let cellWidth = (collectionView.frame.width - (2 * leftRightPadding) - (2 * interSpacing))
            return .init(width: cellWidth, height: cellWidth)
        case .iPhones_X_XS_12MiniSimulator, .iPhone_XR_11, .iPhone_XSMax_ProMax, .iPhone_11Pro, .iPhone_12Mini_13Mini, .iPhone_12_12Pro_13Pro_14, .iPhone_12ProMax_13ProMax_14Plus, .iPhone_14Pro, .iPhone_14ProMax:
            let leftRightPadding = collectionView.frame.width * 0.13
            let interSpacing = collectionView.frame.width * 0.01
            
            let cellWidth = (collectionView.frame.width - (2 * leftRightPadding) - (2 * interSpacing))
            return .init(width: cellWidth, height: cellWidth)
        case .unknown:
            return .init(width: 50, height: 50)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let leftRightPadding = collectionView.frame.width * 0.055
        return .init(top: 16, left: leftRightPadding, bottom: 16, right: leftRightPadding)
    }
}
