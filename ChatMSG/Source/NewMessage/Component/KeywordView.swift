//
//  KeywordView.swift
//  ChatMSG
//
//  Created by Julia on 2023/04/30.
//

import UIKit

final class KeywordView: UIView {
    
    enum KeywordType {
        case messageType
        case writingStyle
    }

    private var keywordType: KeywordType?
    private var messageTypeList: [String] = ["감사", "축하", "초대", "거절", "사과", "문의"]
    private var writingStyleList: [String] = ["공손한 존댓말", "편안한 말투의 해체"]
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .darkGray
        view.font = .systemFont(ofSize: 18, weight: .semibold)
        return view
    }()
    
    private lazy var keywordCollectionView: UICollectionView = {
        let layout = self.generateTagListLayout()
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.isScrollEnabled = false
        view.register(KeywordCell.self)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, type: KeywordType) {
        self.titleLabel.text = title
        self.keywordType = type
    }
    
    private func setUpLayout() {
        [self.titleLabel, self.keywordCollectionView].forEach {
            self.addSubview($0)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        self.keywordCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(130)
        }
    }
    
    private func generateTagListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(40),
            heightDimension: .estimated(25)
        )
        let tagItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.35))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [tagItem])
        group.interItemSpacing = .fixed(8)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
 
}

extension KeywordView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch keywordType {
        case .messageType:
            print("messageTypeList")
            return self.messageTypeList.count
        case .writingStyle:
            return self.writingStyleList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: KeywordCell.self, for: indexPath)
        switch keywordType {
        case .messageType:
            cell.configure(title: self.messageTypeList[indexPath.row])
        case .writingStyle:
            cell.configure(title: self.writingStyleList[indexPath.row])
        default:
            cell.configure(title: "")
        }
        return cell
    }
    
}

extension KeywordView: UICollectionViewDelegate {
    
}


