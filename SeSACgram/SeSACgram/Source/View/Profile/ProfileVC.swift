//
//  ProfileVC.swift
//  SeSACgram
//
//  Created by hoon on 11/14/23.
//

import UIKit

final class ProfileVC: BaseVC {
    
    private let mainView = ProfileView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.profileTableView.delegate = self
        mainView.profileTableView.dataSource = self
        addTargets()
        initialSetting()
    }
    
    override func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.nickNameLabel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.menuButton)
        
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backButtonItem
    }
    
    private func initialSetting() {
        APIManager.shared.checkProfile { result in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self.mainView.nickNameLabel.text = value.nick
                }
            case .failure(let error):
                if let profileError = error as? ProfileError {
                    print("\(profileError.errorDescription)")
                }
            }
        }
    }
    
    static func instance() -> ProfileVC {
        return ProfileVC(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("====\(Self.self)====Deinit")
    }
}

extension ProfileVC: AddTargetProtocol {
    func addTargets() {
        mainView.menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
    }
    
    @objc private func menuButtonTapped() {
        let vc = BottomSheetVC.instance()
        vc.modalDelegate = self
        vc.pushDelegate = self
        addDim()
        present(vc, animated: true, completion: nil)
    }
}


//커스텀 모달
extension ProfileVC: ModalDelegate {
    func onTapClose() {
        self.removeDim()
    }
    
    private func addDim() {
        mainView.setModalBackView()
        DispatchQueue.main.async { [weak self] in
            self?.mainView.modalBackView.alpha = 0.2
        }
    }
    
    private func removeDim() {
        DispatchQueue.main.async { [weak self] in
            self?.mainView.modalBackView.removeFromSuperview()
        }
    }
}

//모달 dismiss후 push로 화면전환
extension ProfileVC: PushableTransition {
    func push(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableCell().description, for: indexPath)
        
        return cell
    }
    
    
    //테이블뷰 헤더
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ProfileHeaderView()
        
        header.profileEditButton.addTarget(self, action: #selector(profileEditButtonTapped), for: .touchUpInside)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 190
    }
    
    @objc private func profileEditButtonTapped() {
        //프로필 편집 버튼
        //프로필 편집 화면으로 전환
    }
    
}
