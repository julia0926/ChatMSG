//
//  UnderLineView.swift
//  ChatMSG
//
//  Created by Julia on 2023/04/27.
//

import UIKit
import Then

final class UnderLineView: UIView {
    
    
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.textColor = .orange
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
    }

    private lazy var infoTextField: UITextField = UITextField().then {
        $0.borderStyle = .none
    }
    
    private lazy var underLineView: UIView = UIView().then {
        $0.backgroundColor = .systemGray4
    }

        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
    }
    
    private func setUpLayout() {
        [self.titleLabel, self.infoTextField, self.underLineView].forEach {
            self.addSubview($0)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        self.infoTextField.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        self.underLineView.snp.makeConstraints { make in
            make.top.equalTo(self.infoTextField.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(2)
        }
    }
    
}
