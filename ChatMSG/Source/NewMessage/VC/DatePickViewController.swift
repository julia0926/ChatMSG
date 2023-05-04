//
//  DatePickViewController.swift
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

final class DatePickViewController: UIViewController {
    var interactor: NewMessageBusinessLogic?
    var router: (NewMessageRoutingLogic & NewMessageDataPassing)?
    var pickerDate: Date?

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
        router.datePickVC = viewController
        router.dataStore = interactor
    }
    
    // MARK: -  UIComponent
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "메세지에 담길 날짜는 언젠가요?"
        view.textColor = .darkGray
        view.font = .systemFont(ofSize: 18, weight: .semibold)
        return view
    }()

    private lazy var datePickerView: UIDatePicker = {
        let view = UIDatePicker()
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .inline
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
        self.settingDatePicker()
        self.settingNextButton()
    }

    func settingDatePicker() {
        self.datePickerView.addTarget(self, action: #selector(changedDatePicker), for: .valueChanged)
    }
    
    @objc private func changedDatePicker(_ sender: UIDatePicker) {
        self.pickerDate = sender.date
        self.nextButton.isEnabled = true
        self.nextButton.setTitleColor(.white, for: .normal)
        self.nextButton.backgroundColor = .orange
    }
    
    private func settingNextButton() {
        self.nextButton.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapNextButton(_ sender: UIButton) {
        if let router = router, let date = self.pickerDate {
            router.datePickRouteToMessageType(date)
        }
    }
    
}

extension DatePickViewController {
    
    private func setUpLayout() {
        [self.titleLabel, self.datePickerView, self.nextButton].forEach {
            self.view.addSubview($0)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(50)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        self.datePickerView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(260)
        }
        
        self.nextButton.snp.makeConstraints { make in
            make.top.equalTo(self.datePickerView.snp.bottom).offset(30)
            make.trailing.equalTo(self.datePickerView.snp.trailing)
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
