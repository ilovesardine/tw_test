//
//  SectionTitleView.swift
//  tw-test
//
//  Created by Krisnandika Aji on 03/07/23.
//

import UIKit

class SectionTitleView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
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
        setConstraints()
    }
    
    private func setUI() {
        backgroundColor = .systemGroupedBackground
        
        addSubview(titleLabel)
    }
    
    private func setConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func populate(title: String) {
        titleLabel.text = title
    }
}
