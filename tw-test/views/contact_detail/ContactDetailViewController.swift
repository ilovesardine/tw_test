//
//  ContactDetailViewController.swift
//  tw-test
//
//  Created by Krisnandika Aji on 03/07/23.
//

import UIKit

protocol ContactDetailDelegate {
    func contactSaved(_ contact: Contact)
}

class ContactDetailViewController: UIViewController {
    private var viewModel: ContactDetailViewModel!
    
    lazy private var cancelBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped(sender:)))
        button.tintColor = Colors.brand
        return button
    }()
    
    lazy private var doneBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped(sender:)))
        button.tintColor = Colors.brand
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        return stackView
    }()
    
    private let avatarView = AvatarView()
    
    var contact: Contact?
    
    var delegate: ContactDetailDelegate?
    
    convenience init(contact: Contact?, delegate: ContactDetailDelegate?) {
        self.init()
        
        self.contact = contact
        self.delegate = delegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }
    
    private func commonInit() {
        setUI()
        setConstraints()
        setBehavior()
        
        viewModel = ContactDetailViewModel(data: contact)
    }
    
    private func setUI() {
        navigationItem.setLeftBarButton(cancelBarButton, animated: true)
        navigationItem.setRightBarButton(doneBarButton, animated: true)
        
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        
        stackView.addArrangedSubview(avatarView)
        
        view.backgroundColor = UIColor.white
    }
    private func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
            make.width.equalTo(scrollView)
        }
    }
    
    private func setBehavior() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func cancelTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func doneTapped(sender: UIBarButtonItem) {
//        guard let newContact = viewModel.saveContact() else {
//            print("Problem saving contact")
//            return
//        }
//
//        delegate?.contactSaved(newContact)
//        navigationController?.popViewController(animated: true)
    }
}
