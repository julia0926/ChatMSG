//
//  UnderLineView.swift
//  ChatMSG
//
//  Created by Julia on 2023/04/27.
//

import UIKit

final class UnderLineView: UIView {
    
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .orange
        view.font = .systemFont(ofSize: 17, weight: .semibold)
        return view
    }()

    private lazy var infoTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .none
        return view
    }()
    
    private lazy var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()

        
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
