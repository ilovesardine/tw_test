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
    
    var container: UIView!
    var bottomConstraint: NSLayoutConstraint!
    
    private let avatarView = AvatarView()
    private let mainSectionTitleView = SectionTitleView()
    private let subSectionTitleView = SectionTitleView()
    
    lazy private var firstNameTextField: TextInputView = {
        let view = TextInputView()
        view.tag = 555
        return view
    }()
    
    lazy private var lastNameTextField: TextInputView = {
        let view = TextInputView()
        view.tag = 556
        return view
    }()
    
    lazy private var emailTextField: TextInputView = {
        let view = TextInputView()
        view.tag = 557
        return view
    }()
    
    lazy private var dateTextField: DateInputView = {
        let view = DateInputView()
        return view
    }()
    
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
        viewModel = ContactDetailViewModel(data: contact)
        
        setUI()
        setConstraints()
        setBehavior()
    }
    
    private func setUI() {
        navigationItem.setLeftBarButton(cancelBarButton, animated: true)
        navigationItem.setRightBarButton(doneBarButton, animated: true)
        
        container = UIView()
        bottomConstraint = container.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        scrollView.addSubview(stackView)
        container.addSubview(scrollView)
        view.addSubview(container)
        
        stackView.addArrangedSubview(avatarView)
        stackView.addArrangedSubview(mainSectionTitleView)
        stackView.addArrangedSubview(firstNameTextField)
        stackView.addArrangedSubview(lastNameTextField)
        stackView.addArrangedSubview(subSectionTitleView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(dateTextField)
        
        firstNameTextField.onNextTriggered = { [weak self] curTag in
            self?.triggerNextField(view: self!.firstNameTextField, currentTag: curTag)
        }
        lastNameTextField.onNextTriggered = { [weak self] curTag in
            self?.triggerNextField(view: self!.lastNameTextField, currentTag: curTag)
        }
        emailTextField.onNextTriggered = { [weak self] curTag in
            self?.triggerNextField(view: self!.emailTextField, currentTag: curTag)
        }
        
        view.backgroundColor = UIColor.white
        
        mainSectionTitleView.populate(title: "Main Information")
        subSectionTitleView.populate(title: "Sub Information")
        
        firstNameTextField.populate("First Name", value: viewModel.data?.firstName)
        lastNameTextField.populate("Last Name", value: viewModel.data?.lastName)
        
        emailTextField.populate("Email", value: viewModel.data?.email)
        dateTextField.populate("DOB", value: viewModel.data?.dob?.date(with: .date))
    }
    private func setConstraints() {
        NSLayoutConstraint.activate([bottomConstraint])
        
        container.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
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
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

           if bottomConstraint.constant == 0 {
              bottomConstraint.constant = -keyboardSize.height
              view.layoutIfNeeded()
           }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
           bottomConstraint.constant = 0
           view.layoutIfNeeded()
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
        let firstName = firstNameTextField.value
        let lastName = lastNameTextField.value
        let email = emailTextField.value
        let dob = dateTextField.value?.string(with: .date)
        
        guard firstName != nil && firstName != "" && lastName != nil && lastName != "" else {
            let dialogMessage = UIAlertController(title: "Incomplete Information", message: "First name and last name must be filled", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .destructive, handler: { (action) -> Void in
                print("Ok button tapped")
            })
            
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
            return
        }
        
        guard let newContact = viewModel.saveContact(firstName: firstName, lastName: lastName, email: email, dob: dob) else {
            print("Problem saving contact")
            return
        }

        delegate?.contactSaved(newContact)
        navigationController?.popViewController(animated: true)
    }
    
    private func triggerNextField(view: TextInputView, currentTag: Int) {
        if let nextField = view.superview?.viewWithTag(currentTag + 1) as? TextInputView {
            nextField.setActive()
        } else {
            view.setInactive()
        }
    }
}
