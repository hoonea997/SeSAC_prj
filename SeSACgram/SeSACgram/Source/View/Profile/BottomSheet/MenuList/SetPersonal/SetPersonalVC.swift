//
//  SetPersonalVC.swift
//  SeSACgram
//
//  Created by hoon on 11/27/23.
//

import UIKit

final class SetPersonalVC: BaseVC {
    
    private let tableViewData = SetPersonalSection.generateData()
    
    private let mainView = SetPersonalView()
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(getReadToBackLogIn), name: Notification.Name.backToLogIn, object: nil)
    }
    
//    private func withdraw() {
//        APIManager.shared.withdraw { [weak self] result in
//            switch result {
//            case .success( _):
//                self?.transitionSignVC()
//            case .failure(let error):
//                if let error = error as? WithdrawError {
//                    switch error {
//                    case .expiredToken:
//                        print("accessToken갱신합니다.")
//                        APIManager.shared.updateToken { result in
//                            switch result {
//                            case .success( _):
//                                APIManager.shared.withdraw { result in
//                                    switch result {
//                                    case .success( _):
//                                        self?.transitionSignVC()
//                                    case .failure(let error):
//                                        if let error = error as? WithdrawError {
//                                            print("\(error.errorDescription)")
//                                        }
//                                    }
//                                }
//                            case .failure(let error):
//                                if let error = error as? TokenError {
//                                    switch error {
//                                    case .expiredRefreshToken:
//                                        self?.showAlert1Button(title: "로그인세션 만료", message: "다시 로그인 후 탈퇴를 진행해주세요") { _ in
//                                            self?.transitionSignVC()
//                                        }
//                                    default:
//                                        print("\(error.errorDescription)")
//                                    }
//                                }
//                            }
//                        }
//                    default:
//                        print("\(error.errorDescription)")
//                    }
//                }
//            }
//        }
//    }
    
    
    private func withdraw() {
        APIManager.shared.withdraw { [weak self] result in
            switch result {
            case .success( _):
                self?.returnToLogIn()
            case .failure(let error):
                if let withdrawError = error as? WithdrawError {
                    print("\(withdrawError.errorDescription)")
                }
            }
        }
    }
    
    @objc private func getReadToBackLogIn() {
        showAlert1Button(title: "로그인 세션 만료", message: "다시 로그인 해주세요") { [weak self] _ in
            self?.returnToLogIn()
        }
    }
}

extension SetPersonalVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let target = tableViewData[indexPath.section].items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SetPersonalTableViewCell().description, for: indexPath) as! SetPersonalTableViewCell
        cell.setCell(data: target)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewData[section].header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let target = tableViewData[indexPath.section].items[indexPath.row].title
        self.didSelect(title: target)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func didSelect(title: Menu.Setpersonal.RawValue) {
        switch title {
        case Menu.Setpersonal.logout.rawValue:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                //???: -
                UserDefaultsHelper.shared.isLogIn = false
                UserDefaultsHelper.shared.removeAccessToken()
                let nav = UINavigationController(rootViewController: SignInVC())
                self.view?.window?.rootViewController = nav
                self.view.window?.makeKeyAndVisible()
            }
        case Menu.Setpersonal.withdraw.rawValue:
            print("탈퇴누르기")
            self.showAlert2Button(title: "정말 탈퇴하시겠어요?", message: "진짜??") { [weak self] _ in
                self?.withdraw()
            }
        default:
            break
        }
    }
}
