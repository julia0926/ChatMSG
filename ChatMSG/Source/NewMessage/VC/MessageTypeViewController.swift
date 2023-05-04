//
//  MessageTypeViewController.swift
//  ChatMSG
//
//  Created by Julia on 2023/05/02.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

final class MessageTypeViewController: UIViewController {
    var interactor: NewMessageBusinessLogic?
    var router: (NewMessageRoutingLogic & NewMessageDataPassing)?
    
    private var messageType: String?
    private var writingStyle: String?

    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = NewMessageInteractor.shared
        let router = NewMessageRouter.shared
        viewController.interactor = interactor
        viewController.router = router
        router.typeVC = viewController
        router.dataStore = interactor
    }
    
    // MARK: -  UIComponent
    private let typeKeywordView: KeywordView =  {
        let view = KeywordView()
        view.configure(type: .messageType,
                       title: "어떤 타입의 메세지인가요?")
        return view
    }()
    
    private let writingStyleKeywordView: KeywordView =  {
        let view = KeywordView()
        view.configure(type: .writingStyle,
                       title: "메세지의 어체를 선택해주세요.")
        return view
    }()
    
    private let nextButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("NEXT", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderColor = UIColor.orange.cgColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.setUpLayout()
        self.settingKeywordView()
        self.settingNextButton()
    }
    
    private func settingKeywordView() {
        self.typeKeywordView.delegate = self
        self.writingStyleKeywordView.delegate = self
    }
    
    private func settingNextButton() {
        self.nextButton.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapNextButton(_ sender: UIButton) {
        if let router = router,
            let type = self.messageType,
            let style = writingStyle {
            router.messageTypeRouteToSituation(type: type, writingStyle: style)
        }
    }
    
}

extension MessageTypeViewController: KeywordViewDelegate {
    func getMessageType(_ type: String) {
        self.messageType = type
    }

    func getWritingStyle(_ style: String) {
        self.writingStyle = style
    }
}

extension MessageTypeViewController {
    
    private func setUpLayout() {
        [self.typeKeywordView, self.writingStyleKeywordView,  self.nextButton].forEach {
            self.view.addSubview($0)
        }
        
        self.typeKeywordView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(50)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(140)
        }
        
        self.writingStyleKeywordView.snp.makeConstraints { make in
            make.top.equalTo(self.typeKeywordView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(70)
        }
        
        self.nextButton.snp.makeConstraints { make in
            make.top.equalTo(self.writingStyleKeywordView.snp.bottom).offset(30)
            make.trailing.equalTo(self.writingStyleKeywordView.snp.trailing)
            make.width.equalTo(70)
            make.height.equalTo(35)
        }
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .orange
    }

}
