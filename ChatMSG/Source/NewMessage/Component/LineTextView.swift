//
//  LineTextView.swift
//  ChatMSG
//
//  Created by Julia on 2023/05/02.
//

import UIKit
import SnapKit

protocol LineTextViewDelegate: AnyObject {
    func updateButtonState(_ flag: Bool)
    func getTextViewText(_ text: String)
}

final class LineTextView: UIView {
    
    weak var delegate: LineTextViewDelegate?
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .darkGray
        view.font = .systemFont(ofSize: 18, weight: .semibold)
        return view
    }()
    
    private let textView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 15, weight: .medium)
        view.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
    }()
    
    private let textCountLabel: UILabel = {
        let view = UILabel()
        view.textColor = .gray
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.text = "0"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpLayout()
        self.textView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
    }
    
    private func setUpLayout() {
        [self.titleLabel, self.textView, self.textCountLabel].forEach {
            self.addSubview($0)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        self.textView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        self.textCountLabel.snp.makeConstraints { make in
            make.top.equalTo(self.textView.snp.bottom).offset(15)
            make.trailing.equalTo(self.textView.snp.trailing).inset(5)
            make.bottom.equalToSuperview()
        }
    }
}

extension LineTextView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.textView.layer.borderColor = UIColor.orange.cgColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.textView.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let _text = textView.text {
            let newLength = _text.count + text.count - range.length
            delegate?.updateButtonState(newLength >= 10)
            self.textCountLabel.text = "\(newLength)"
            delegate?.getTextViewText(_text)
        }
        return true
    }
    
}
