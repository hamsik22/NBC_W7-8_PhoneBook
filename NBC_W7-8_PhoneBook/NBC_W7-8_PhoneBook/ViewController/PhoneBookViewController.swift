//
//  PhoneBookViewController.swift
//  NBC_W7-8_PhoneBook
//
//  Created by 황석현 on 12/9/24.
//

import SwiftUI
import UIKit
import SnapKit
import Alamofire

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
        image.clipsToBounds = true
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
    
    private var phoneBookData: PhoneBookData?
    
    weak var delegate: HomeViewControllerDelegate?
    
    private var imageUrlString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTitle()
        setupRightBarButton()
        setupProfile()
        setupUI()
    }
    
    private func setupRightBarButton() {
        if let _ = phoneBookData {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(updatePhoneData))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(createPhoneData))
        }
    }
    
    private func setupTitle() {
        if let phoneBookData = phoneBookData {
            title = phoneBookData.name
        } else {
            title = "연락처 추가"
        }
    }
    
    private func setupProfile() {
        if let phoneBookData = phoneBookData {
            nameLabel.text = phoneBookData.name
            phoneNumberLabel.text = phoneBookData.phoneNumber
            setProfileImage()
        } else {
            nameLabel.text = ""
            phoneNumberLabel.text = ""
        }
    }
    
    private func setupUI() {
        if let _ = phoneBookData { } else { generateRandomImage() }
        [profileImage, imageButton, nameLabel, phoneNumberLabel]
            .forEach { stackView.addSubview($0) }
        
        profileImage.snp.makeConstraints { image in
            image.top.equalTo(stackView.snp.top)
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
        
        imageButton.addTarget(self, action: #selector(generateRandomImage), for: .touchUpInside)
        
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
            stack.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            
        }
    }
    
    @objc private func createPhoneData() {
        delegate?.createItemButtonTapped(profile: imageUrlString, name: nameLabel.text, phoneNumber: phoneNumberLabel.text)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func updatePhoneData() {
        delegate?.updateItemButtonTappedfunc(oldValue: phoneBookData, profile: imageUrlString, name: nameLabel.text, phoneNumber: phoneNumberLabel.text)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func generateRandomImage() {
        print("이미지 생성")
        let urlComponents = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/\(Int.random(in: 1...1000))")
        guard let url = urlComponents?.url else { return }
        
        fetchDataByAlamofire(url: url) { [weak self] (result: Result<Poketmon, AFError>) in
            switch result {
            case .success(let result):
                let imageUrl = result.sprites.frontDefault
                self?.imageUrlString = imageUrl
                AF.request(imageUrl).responseData { response in
                    guard let data = response.data else { return }
                    DispatchQueue.main.async {
                        self?.profileImage.image = UIImage(data: data)
                    }
                }
            case .failure(let error):
                print("error : \(error)")
            }
        }
    }
    
    func setPhoneBookData(data: PhoneBookData) {
        self.phoneBookData = data
    }
    
    private func setProfileImage() {
        guard let imageUrlString = phoneBookData?.image else { return }
        let urlComponents = URLComponents(string: imageUrlString)
        guard let url = urlComponents?.url else { return }
        
        AF.request(url).response { respose in
            if let data = respose.data {
                DispatchQueue.main.async {
                    self.profileImage.image = UIImage(data: data)
                }
            }
        }
    }
    
    private func fetchDataByAlamofire<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(url).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }

}

#Preview(body: {
    PhoneBookViewController().toPreview()
})
