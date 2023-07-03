//
//  ContactListItemCell.swift
//  tw-test
//
//  Created by Krisnandika Aji on 03/07/23.
//

import UIKit
import SnapKit

class ContactListItemCell: UICollectionViewCell {
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 8
        view.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()
    
    private let avatarView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = Colors.brand
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
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
        setSubviews()
        setConstraints()
    }
    
    private func setUI() {
        contentView.clipsToBounds = false
        
        stackView.backgroundColor = .white
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1).cgColor
    }
    
    private func setSubviews() {
        stackView.addArrangedSubview(avatarView)
        stackView.addArrangedSubview(nameLabel)
        
        contentView.addSubview(stackView)
    }
    
    private func setConstraints() {
        avatarView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        stackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().inset(8)
        }
    }
    
    func populate(with data: Contact) {
        nameLabel.text = data.fullname
    }
}
