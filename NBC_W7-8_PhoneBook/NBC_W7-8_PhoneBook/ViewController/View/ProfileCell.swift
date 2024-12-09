//
//  ProfileCell.swift
//  NBC_W7-8_PhoneBook
//
//  Created by 황석현 on 12/9/24.
//

import UIKit
import SnapKit

class ProfileCell: UITableViewCell {
    
    let profileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 30
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.black.cgColor
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "phoneNumber"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [profileImage, nameLabel, phoneNumberLabel]
            .forEach { contentView.addSubview($0) }
        
        profileImage.snp.makeConstraints { view in
            view.left.equalToSuperview().offset(30)
            view.width.equalTo(60)
            view.height.equalTo(60)
            view.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { name in
            name.left.equalTo(profileImage.snp.right).offset(20)
            name.width.equalTo(100)
            name.centerY.equalToSuperview()
        }
        
        phoneNumberLabel.snp.makeConstraints { phone in
            phone.left.equalTo(nameLabel.snp.right).offset(10)
            phone.right.equalToSuperview()
            phone.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
