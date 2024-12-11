//
//  PhoneBookViewController.swift
//  NBC_W7-8_PhoneBook
//
//  Created by 황석현 on 12/9/24.
//

import SwiftUI
import UIKit
import SnapKit

class PhoneBookViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 100
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.black.cgColor
        return image
    }()
    
    private let imageButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let nameLabel: UITextView = {
        let label = UITextView()
        label.text = "Name"
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        label.layer.cornerRadius = 10
        return label
    }()
    
    private let phoneNumberLabel: UITextView = {
        let label = UITextView()
        label.text = "Phone Number"
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        label.layer.cornerRadius = 10
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .red
        setupUI()
    }
    
    private func setupUI() {
        [profileImage, imageButton, nameLabel, phoneNumberLabel]
            .forEach { stackView.addSubview($0) }
        
        profileImage.snp.makeConstraints { image in
            image.top.equalToSuperview().offset(20)
            image.centerX.equalToSuperview()
            image.width.equalTo(200)
            image.height.equalTo(200)
        }
        
        imageButton.snp.makeConstraints { button in
            button.top.equalTo(profileImage.snp.bottom).offset(20)
            button.centerX.equalToSuperview()
            button.width.equalTo(100)
            button.height.equalTo(30)
            button.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { name in
            name.top.equalTo(imageButton.snp.bottom).offset(20)
            name.left.equalToSuperview().inset(20)
            name.right.equalToSuperview().inset(20)
            name.height.equalTo(50)
        }
        
        phoneNumberLabel.snp.makeConstraints { number in
            number.top.equalTo(nameLabel.snp.bottom).offset(5)
            number.left.equalToSuperview().inset(20)
            number.right.equalToSuperview().inset(20)
            number.height.equalTo(50)
        }
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { stack in
            stack.width.equalToSuperview()
            stack.top.equalToSuperview()
            
        }
    }

}

#Preview(body: {
    PhoneBookViewController().toPreview()
})

#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
    
    func toPreview() -> some View {
        Preview(viewController: self)
    }
}
#endif
