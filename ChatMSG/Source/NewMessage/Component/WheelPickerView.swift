//
//  WheelPickerView.swift
//  ChatMSG
//
//  Created by Julia on 2023/04/30.
//

import UIKit

final class WheelPickerView: UIView {
    
    enum WheelType {
        case date
        case number
    }

    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .darkGray
        view.font = .systemFont(ofSize: 18, weight: .semibold)
        return view
    }()
    
    private let messageMinimumLine: [String] = ["100", "200", "300", "400", "500"]
    
    private lazy var datePickerView: UIDatePicker = {
        let view = UIDatePicker()
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .wheels
        return view
    }()
    
    private lazy var numberPickerView: UIPickerView = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpCommonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(type: WheelType, title: String) {
        self.titleLabel.text = title
        switch type {
        case .date:
            self.setUpDatePickerViewLayout()
        case .number:
            self.setUpNumberPickerViewLayout()
        }
    }
    
    private func setUpCommonLayout() {
        self.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }
    
    private func setUpDatePickerViewLayout() {
        self.addSubview(self.datePickerView)
        
        self.datePickerView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setUpNumberPickerViewLayout() {
        self.addSubview(self.numberPickerView)
        
        self.numberPickerView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension WheelPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.messageMinimumLine.count
    }
}

extension WheelPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.messageMinimumLine[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(self.messageMinimumLine[row])
    }


}
