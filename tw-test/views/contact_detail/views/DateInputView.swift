//
//  DateInputView.swift
//  tw-test
//
//  Created by Krisnandika Aji on 03/07/23.
//

import UIKit

class DateInputView: UIView {
    
    var value: Date? {
        get { textField.text?.date(with: .date) }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy private var textField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.textAlignment = .left
        textField.returnKeyType = .next
        textField.tag = tag
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        let image = UIImage(systemName: "calendar.badge.plus")
        let imageView = UIImageView(image: image)
        imageView.tintColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        
        textField.rightView = imageView
        textField.rightViewMode = .always
        return textField
    }()
    
    private let datePicker = UIDatePicker()
    private let toolbar = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 100))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUI()
        setConstraints()
    }
    
    private func setUI() {
        addSubview(label)
        addSubview(textField)
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .date
        
        textField.inputView = datePicker
        
        configureToolbar()
    }
    
    private func setConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(90)
        }
        
        textField.snp.makeConstraints { make in
            make.leading.equalTo(label.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        label.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private func configureToolbar() {
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.sizeToFit()
        
        textField.inputAccessoryView = toolbar
    }
    
    @objc
    private func doneTapped() {
        textField.text = datePicker.date.string(with: .datePretty)
        endEditing(true)
    }
    
    func populate(_ title: String, value: Date?) {
        label.text = title
        
        textField.placeholder = title
        
        if let value = value {
            textField.text = value.string(with: .datePretty)
            datePicker.date = value
        }
    }
}
