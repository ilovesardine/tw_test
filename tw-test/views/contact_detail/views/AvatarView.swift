//
//  AvatarView.swift
//  tw-test
//
//  Created by Krisnandika Aji on 03/07/23.
//

import UIKit

class AvatarView: UIView {
    
    private let avatarView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = Colors.brand
        view.layer.cornerRadius = 50
        return view
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
        addSubview(avatarView)
        
        snp.makeConstraints { make in
            make.height.equalTo(120)
        }
        
        avatarView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(100)
        }
    }
}
