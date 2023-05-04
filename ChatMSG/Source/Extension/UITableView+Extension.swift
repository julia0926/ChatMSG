//
//  UITableView+Extension.swift
//  ChatMSG
//
//  Created by Julia on 2023/05/01.
//

import UIKit

extension UITableView {

    func register<Cell: UITableViewCell>(_ type: Cell.Type) {
        self.register(type, forCellReuseIdentifier: String(describing: type))
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(
        type: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as? Cell else {
            fatalError("identifier: \(String(describing: type)) can not dequeue cell")
        }
        return cell
    }
}
