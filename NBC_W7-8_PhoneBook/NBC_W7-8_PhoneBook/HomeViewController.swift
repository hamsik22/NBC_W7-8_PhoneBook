//
//  ViewController.swift
//  NBC_W7-8_PhoneBook
//
//  Created by 황석현 on 12/9/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "친구 목록"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let addItemButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.opacity = 0.5
        return button
    }()
    
    
    
    let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    // 임시 데이터
    var mockData: [PhoneBookData] = [PhoneBookData(image: UIImage(systemName: "person"),
                                                   name: "name", phoneNumber: "010-0000-0000"),
                                     PhoneBookData(image: UIImage(systemName: "person"),
                                                   name: "name", phoneNumber: "010-0000-0000"),
                                     PhoneBookData(image: UIImage(systemName: "person"),
                                                   name: "name", phoneNumber: "010-0000-0000"),
                                     PhoneBookData(image: UIImage(systemName: "person"),
                                                   name: "name", phoneNumber: "010-0000-0000"),
                                     PhoneBookData(image: UIImage(systemName: "person"),
                                                   name: "name", phoneNumber: "010-0000-0000"),
                                     PhoneBookData(image: UIImage(systemName: "person"),
                                                   name: "name", phoneNumber: "010-0000-0000")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        setupTopStackView()
        setupProfileTableView()
        
        [topStackView, mainTableView]
            .forEach { view.addSubview($0) }
        
        topStackView.snp.makeConstraints { title in
            title.top.equalToSuperview().offset(75)
            title.width.equalToSuperview()
            title.height.equalTo(50)
            title.centerX.equalToSuperview()
        }
        
        mainTableView.snp.makeConstraints { table in
            table.top.equalTo(topStackView.snp.bottom)
            table.width.equalToSuperview()
            table.bottom.equalToSuperview()
            table.centerX.equalToSuperview()
        }
    }
    
    private func setupTopStackView() {
        [titleLabel,addItemButton]
            .forEach{ topStackView.addSubview($0) }
        
        titleLabel.snp.makeConstraints { title in
            title.top.equalToSuperview()
            title.centerX.equalToSuperview()
        }
        
        addItemButton.snp.makeConstraints { button in
            button.top.equalToSuperview()
            button.centerY.equalTo(titleLabel.snp.centerY)
            button.right.equalToSuperview().inset(30)
            button.width.equalTo(50)
        }
    }
    
    private func setupProfileTableView() {
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(ProfileCell.self, forCellReuseIdentifier: "profileCell")
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as? ProfileCell else { fatalError() }
        cell.nameLabel.text = mockData[indexPath.row].name
        cell.phoneNumberLabel.text = mockData[indexPath.row].phoneNumber
        //TODO: 이미지 할당 필요
        
        return cell
    }
    
}

/// 연락처 정보
struct PhoneBookData {
    let id = UUID()
    let image: UIImage?
    let name: String
    let phoneNumber: String
}

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