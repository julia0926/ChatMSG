//
//  UICollectionView+Extension.swift
//  ChatMSG
//
//  Created by Julia on 2023/05/01.
//

import UIKit

extension UICollectionView {
    
    func register<Cell: UICollectionViewCell>(_ type: Cell.Type) {
        self.register(type, forCellWithReuseIdentifier: String(describing: type))
    }
    
    func register<SupplementaryView: UICollectionReusableView>(
        _ type: SupplementaryView.Type,
        supplementaryViewOfKind kind: String
    ) {
        self.register(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: type))
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(
        type: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as? Cell else {
            fatalError("identifier: \(String(describing: type)) can not dequeue cell")
        }
        return cell
    }
    
    func dequeueReusableSupplementaryView<SupplementaryView: UICollectionReusableView>(
        kind: String,
        type: SupplementaryView.Type,
        for indexPath: IndexPath
    ) -> SupplementaryView {
        guard let supplementaryView = self.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: String(describing: type),
            for: indexPath
        ) as? SupplementaryView else {
            fatalError("identifier: \(String(describing: type)) can not dequeue resuable view")
        }
        return supplementaryView
    }
}

