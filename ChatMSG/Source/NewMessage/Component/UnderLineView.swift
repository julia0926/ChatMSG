//
//  UnderLineView.swift
//  ChatMSG
//
//  Created by Julia on 2023/04/27.
//

import UIKit

protocol UnderLineViewDelegate: AnyObject {
    func updateButtonState(_ flag: Bool)
    func getTextFieldText(_ text: String)
}

final class UnderLineView: UIView {
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .darkGray
        view.font = .systemFont(ofSize: 18, weight: .semibold)
        return view
    }()

    private let infoTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.clearButtonMode = .whileEditing
        return view
    }()
    
    private let underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    weak var delegate: UnderLineViewDelegate?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpLayout()
        self.infoTextField.delegate = self
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

extension UnderLineView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.underLineView.backgroundColor = .orange
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.underLineView.backgroundColor = .lightGray
        if let text = textField.text {
            delegate?.updateButtonState(text.count >= 3)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            let newLength = text.count + string.count - range.length
            delegate?.updateButtonState(newLength >= 3)
            delegate?.getTextFieldText(text)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
       return true
   }
}
