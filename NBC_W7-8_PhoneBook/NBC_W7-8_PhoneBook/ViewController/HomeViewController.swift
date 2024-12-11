//
//  ViewController.swift
//  NBC_W7-8_PhoneBook
//
//  Created by 황석현 on 12/9/24.
//

import UIKit
import SnapKit
import CoreData

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
    
    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        title = "친구 목록"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addItemButton)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        createCoreData(profile: "URL", name: "Test1", phoneNumber: "010-111-222")
        readCoreData()
        updateCoreData(oldName: "Test1", newName: "Success")
        deleteCoreData(name: "Success")
        deleteCoreData(name: "Name")
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
        phoneBookVC.delegate = self
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
    
    // MARK: - CoreData
    
    // TODO: 데이터 생성
    func createCoreData(profile: String, name: String, phoneNumber: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: PhoneBook.className, in: self.container.viewContext) else { return }
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        newPhoneBook.setValue(profile, forKey: PhoneBook.Key.profile)
        newPhoneBook.setValue(name, forKey: PhoneBook.Key.name)
        newPhoneBook.setValue(phoneNumber, forKey: PhoneBook.Key.phoneNumber)
        
        do {
            try self.container.viewContext.save()
            print("저장 성공: ", !profile.isEmpty, name, phoneNumber)
        } catch {
            print("저장 실패: ", name, phoneNumber)
            print("Error: ", error)
        }
    }
    // TODO: 데이터 조회
    func readCoreData() {
        do {
            let phoneBooks = try self.container.viewContext.fetch(PhoneBook.fetchRequest())
            
            for phoneBook in phoneBooks as [NSManagedObject] {
                if let name = phoneBook.value(forKey: PhoneBook.Key.name) as? String,
                   let phoneNumber = phoneBook.value(forKey: PhoneBook.Key.phoneNumber) as? String,
                   let profile = phoneBook.value(forKey: PhoneBook.Key.profile) {
                    print("profile: \(profile), name: \(name), phoneNumber: \(phoneNumber)")
                }
            }
        } catch {
            print("데이터 읽기 실패")
            print("Error: ", error)
        }
    }
    // TODO: 데이터 변경
    func updateCoreData(oldName: String, newName: String) {
        let fetchRequest = PhoneBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", oldName)
        do {
            let result = try self.container.viewContext.fetch(fetchRequest)
            
            for data in result as [NSManagedObject] {
                data.setValue(newName, forKey: PhoneBook.Key.name)
                
                try self.container.viewContext.save()
                print("데이터 수정 완료: \(oldName) -> \(newName)")
            }
        } catch {
            print("데이터 수정 실패")
            print("Error: ", error)
        }
    }
    // TODO: 데이터 삭제
    func deleteCoreData(name: String) {
        let fetchRequest = PhoneBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let result = try self.container.viewContext.fetch(fetchRequest)
            
            for data in result as [NSManagedObject] {
                self.container.viewContext.delete(data)
                print("\(name) 삭제")
            }
            
            try self.container.viewContext.save()
            print("\(name) 삭제완료")
        } catch {
            print("데이터 삭제 실패")
            print("Error: ", error)
        }
    }
    
}

extension HomeViewController: HomeViewControllerDelegate {
    func addItemButtonTapped(profile: String, name: String, phoneNumber: String) {
        createCoreData(profile: profile, name: name, phoneNumber: phoneNumber)
    }
}

protocol HomeViewControllerDelegate: AnyObject {
    func addItemButtonTapped(profile: String, name: String, phoneNumber: String)
}
