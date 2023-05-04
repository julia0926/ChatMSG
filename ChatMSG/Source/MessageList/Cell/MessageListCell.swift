//
//  MessageListCell.swift
//  ChatMSG
//
//  Created by Julia on 2023/05/01.
//

import UIKit
import SnapKit

final class MessageListCell: UITableViewCell {
        
    private let messageTypeLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .semibold)
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.textAlignment = .center
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let writedDateLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12, weight: .medium)
        view.textColor = .gray
        return view
    }()
    
    private let receiverLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17, weight: .bold)
        return view
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: MessageList.Something.ViewModel.DisplayedMessage) {
        self.messageTypeLabel.text = data.type
        self.writedDateLabel.text = data.createdDate
        self.receiverLabel.text = data.receiver
    }
    
    private func setUpLayout() {
        [self.messageTypeLabel, self.writedDateLabel, self.receiverLabel].forEach {
            self.addSubview($0)
        }
        
        self.messageTypeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
        self.writedDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.messageTypeLabel.snp.trailing).offset(15)
            make.top.equalToSuperview().offset(25)
        }

        self.receiverLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.messageTypeLabel.snp.trailing).offset(15)
            make.bottom.equalToSuperview().inset(30)
       }
        
    }
    
    
}
