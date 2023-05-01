//
//  KeywordCell.swift
//  ChatMSG
//
//  Created by Julia on 2023/05/01.
//

import UIKit
import SnapKit

final class KeywordCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .medium)
        view.textColor = .darkGray
        view.textAlignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
        self.setUpLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
        print(title)
    }
    
    private func setUp() {
        self.backgroundColor = .systemGray5
        self.layer.cornerRadius = 8
    }
    
    private func setUpLayout() {
        self.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
}

