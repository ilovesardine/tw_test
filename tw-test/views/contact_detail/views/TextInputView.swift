//
//  TextInputView.swift
//  tw-test
//
//  Created by Krisnandika Aji on 03/07/23.
//

import UIKit

class TextInputView: UIView {
    
    var value: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    var onNextTriggered: ((Int) -> Void)?
    
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
        textField.rightView = paddingView
        textField.rightViewMode = .always
        return textField
    }()
    
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
        
        textField.delegate = self
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
    
    func populate(_ title: String, value: String?) {
        label.text = title
        
        textField.placeholder = title
        textField.text = value
    }
    
    func setActive() {
        textField.becomeFirstResponder()
    }
    
    func setInactive() {
        textField.resignFirstResponder()
    }
}

extension TextInputView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onNextTriggered?(tag)
        return true
    }
}
