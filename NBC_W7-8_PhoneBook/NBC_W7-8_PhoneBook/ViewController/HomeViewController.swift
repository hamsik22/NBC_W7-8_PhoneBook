//
//  ViewController.swift
//  NBC_W7-8_PhoneBook
//
//  Created by 황석현 on 12/9/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let topLabel: UIView = {
        let stackView = UIView()
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "친구 목록"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
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
                                                   name: "name", phoneNumber: "010-0000-1234"),
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
        title = "친구 목록"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addItemButton)
    }
    
    private func setupUI() {
        setupProfileTableView()
        
        view.addSubview(mainTableView)
        
        addItemButton.addTarget(self, action: #selector(goToPhoneBookVC), for: .touchUpInside)
        
        mainTableView.snp.makeConstraints { table in
            table.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            table.width.equalToSuperview()
            table.bottom.equalToSuperview()
            table.centerX.equalToSuperview().inset(20)
        }
    }
    
    private func setupTopLabel() {
        [titleLabel, addItemButton]
            .forEach { topLabel.addSubview($0) }
        
        
        titleLabel.snp.makeConstraints { make in
            
            make.center.equalTo(topLabel)
            make.width.equalTo(150)
        }
        
        addItemButton.snp.makeConstraints { make in
            make.right.equalTo(topLabel).inset(20)
            make.centerY.equalTo(topLabel)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
    }
    private func setupProfileTableView() {
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(ProfileCell.self, forCellReuseIdentifier: "profileCell")
    }
    
    @objc func goToPhoneBookVC() {
        print("화면이동")
        let phoneBookVC = PhoneBookViewController()
        if let navigationController = navigationController {
            navigationController.pushViewController(phoneBookVC, animated: true)
        }
    }
    
}

// MARK: - Extensions
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
