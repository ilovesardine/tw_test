//
//  ViewController.swift
//  tw-test
//
//  Created by Krisnandika Aji on 03/07/23.
//

import UIKit

class ContactListViewController: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    lazy private var viewModel = ContactListViewModel()
    
    lazy private var searchBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped(_:)))
        button.tintColor = Colors.brand
        return button
    }()
    
    lazy private var addBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
        button.tintColor = Colors.brand
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ContactListItemCell.self, forCellWithReuseIdentifier: ContactListItemCell.description())
        return collectionView
    }()
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }
    
    private func commonInit() {
        setUI()
        setConstraints()
        setObservers()
        setBehavior()
    }
    
    private func setUI() {
        navigationController?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationItem.title = "Contacts"
        
        navigationItem.setRightBarButton(addBarButton, animated: true)
        navigationItem.setLeftBarButton(searchBarButton, animated: true)
        
        refreshControl.addTarget(self, action: #selector(refreshControlTriggered(_:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        view.addSubview(collectionView)
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setObservers() {
        viewModel.dataSource.bind { [weak self] dataSource in
            DispatchQueue.main.async {
                self?.collectionView.dataSource = dataSource
                self?.collectionView.delegate = dataSource
                self?.collectionView.reloadSections(IndexSet(integer: 0))
            }
        }
    }
    
    private func setBehavior() {
        viewModel.selectionHandler = {[weak self] contact in
            DispatchQueue.main.async {
                self?.navigationController?.pushViewController(ContactDetailViewController(contact: contact, delegate: self), animated: true)
            }
        }
    }
    
    @objc
    private func searchTapped(_ sender: UIBarButtonItem) {
        
    }
    
    @objc
    private func addTapped(_ sender: UIBarButtonItem) {
        navigationController?.pushViewController(ContactDetailViewController(contact: nil, delegate: self), animated: true)
    }
    
    @objc
    private func refreshControlTriggered(_ sender: UIRefreshControl) {
        refreshControl.endRefreshing()
        viewModel.refreshData()
    }
}

extension ContactListViewController: ContactDetailDelegate {
    func contactSaved(_ contact: Contact) {
        viewModel.saveContact(contact)
    }
}

