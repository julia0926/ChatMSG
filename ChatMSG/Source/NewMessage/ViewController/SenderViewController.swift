//
//  SenderViewController.swift
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

final class SenderViewController: UIViewController {
    var interactor: NewMessageBusinessLogic?
    var router: (NewMessageRoutingLogic & NewMessageDataPassing)?
    var textFieldText: String?

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
        router.senderVC = viewController
        router.dataStore = interactor
    }
    
    // MARK: -  UIComponent
    private let senderTextField: UnderLineView =  {
        let view = UnderLineView()
        view.configure(title: "보내는 사람을 작성해주세요.")
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
        self.setUpLayout()
        self.configureUI()
        self.settingNextButton()
        self.senderTextField.delegate = self
    }

    
    private func settingNextButton() {
        self.nextButton.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapNextButton(_ sender: UIButton) {
        if let router = router, let text = self.textFieldText {
            router.senderRouteToDatePick(text)
        }
    }

    
}

extension SenderViewController: UnderLineViewDelegate {
    func getTextFieldText(_ text: String) {
        self.textFieldText = text
    }
    
    func updateButtonState(_ flag: Bool) {
        let buttonTitleColor: UIColor = flag ? .white : .black
        let buttonBackgroundColor: UIColor = flag ? .orange : .clear
        self.nextButton.setTitleColor(buttonTitleColor, for: .normal)
        self.nextButton.backgroundColor = buttonBackgroundColor
        self.nextButton.isEnabled = flag
    }
    
}

extension SenderViewController {
    
    private func setUpLayout() {
        [self.senderTextField, self.nextButton].forEach {
            self.view.addSubview($0)
        }
        
        self.senderTextField.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(50)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(140)
        }
        
        self.nextButton.snp.makeConstraints { make in
            make.top.equalTo(self.senderTextField.snp.bottom).offset(30)
            make.trailing.equalTo(self.senderTextField.snp.trailing)
            make.width.equalTo(70)
            make.height.equalTo(35)
        }
        
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = ". 🐢 . . ."
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .orange
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
