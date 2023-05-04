//
//  MessageDetailViewController.swift
//  ChatMSG
//
//  Created by Julia on 2023/05/04.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@MainActor
protocol MessageDetailDisplayLogic: AnyObject {
    func displaySomething(viewModel: MessageDetail.Something.ViewModel)
}

final class MessageDetailViewController: UIViewController, MessageDetailDisplayLogic {
    var interactor: MessageDetailBusinessLogic?
    var router: (MessageDetailRoutingLogic & MessageDetailDataPassing)?
    
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
        let interactor = MessageDetailInteractor()
        let presenter = MessageDetailPresenter()
        let router = MessageDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: -  UIComponent
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .systemFont(ofSize: 20, weight: .bold)
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let view = UILabel()
        view.textColor = .gray
        view.font = .systemFont(ofSize: 15, weight: .medium)
        view.numberOfLines = 0
        return view
    }()

    private let messageTextView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 15, weight: .medium)
        view.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.orange.cgColor
        return view
    }()
    
    private let copyButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "doc.on.doc.fill"), for: .normal)
        btn.tintColor = .lightGray
        return btn
    }()
    
    private let shareButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("🔗 공유", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        btn.layer.cornerRadius = 20
        btn.layer.backgroundColor = UIColor.orange.cgColor
        btn.clipsToBounds = true
        return btn
    }()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.setUpLayout()
        fetchMessage()
        self.configureButton()
    }
    
    private func configureButton() {
        self.copyButton.addTarget(self, action: #selector(tappedCopyButton), for: .touchUpInside)
        self.shareButton.addTarget(self, action: #selector(tappedShareButton), for: .touchUpInside)
    }
    
    @objc private func tappedCopyButton() {
        guard let text = messageTextView.text else { return }
        UIPasteboard.general.string = text
        self.showToast("메세지를 복사했어요!", withDuration: 2.0, delay: 1.5)
    }
    
    @objc private func tappedShareButton() {
        guard let text = messageTextView.text else { return }
        let item: [String] = ["\(text)"]
        let vc = UIActivityViewController(activityItems: item, applicationActivities: nil)
        present(vc, animated: true)
    }
    
    // VIP Cycle Start
    func fetchMessage() {
        let request =  MessageDetail.Something.Request()
        interactor?.fetchMessage(request: request)
    }
    
    // MARK: - Display Logic
  
    func displaySomething(viewModel: MessageDetail.Something.ViewModel) {
        self.titleLabel.text = viewModel.displayedMessage.title
        self.descriptionLabel.text = viewModel.displayedMessage.description
        self.messageTextView.text = viewModel.displayedMessage.result
    }
    
}

extension MessageDetailViewController {
    private func setUpLayout() {
        [self.titleLabel, self.descriptionLabel, self.messageTextView, self.copyButton, self.shareButton].forEach {
            self.view.addSubview($0)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        self.messageTextView.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(400)
        }
        
        self.copyButton.snp.makeConstraints { make in
            make.top.equalTo(self.messageTextView.snp.top).inset(10)
            make.trailing.equalTo(self.messageTextView.snp.trailing).inset(10)
            make.height.equalTo(30)
        }
        
        self.copyButton.snp.makeConstraints { make in
            make.top.equalTo(self.messageTextView.snp.top).inset(10)
            make.trailing.equalTo(self.messageTextView.snp.trailing).inset(10)
            make.height.equalTo(30)
        }
        
        self.shareButton.snp.makeConstraints { make in
            make.top.equalTo(self.messageTextView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .orange
    }
    
    private func showToast(_ message : String, withDuration: Double, delay: Double) {
        let label = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 160, height: 40))
        label.backgroundColor = UIColor.systemBlue
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .semibold)
        label.textAlignment = .center
        label.text = message
        label.alpha = 1.0
        label.layer.cornerRadius = 16
        label.clipsToBounds  =  true
        
        self.view.addSubview(label)

        UIView.animate(withDuration: withDuration, delay: delay, options: .curveEaseOut) {
            label.alpha = 0.0
        } completion: { _ in
            label.removeFromSuperview()
        }
    }
}
