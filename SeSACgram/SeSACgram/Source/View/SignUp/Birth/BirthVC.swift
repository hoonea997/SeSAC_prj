//
//  BirthVC.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import UIKit
import Toast

final class BirthVC: BaseVC {
    private let email = UserDefaultsHelper.shared.email
    private let pw = UserDefaultsHelper.shared.pw
    private let nickname = UserDefaultsHelper.shared.nickname
    private let phone = UserDefaultsHelper.shared.phone ?? ""
    
    private let mainView = BirthView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.delegate = self
        self.hideKeyboardWhenTappedAround()
        addTargets()
    }
    
    deinit {
        print("====\(Self.self)====Deinit")
    }
    
    //회원가입 api
    private func signUp() {
        let data = SignUp(email: email, password: pw, nick: nickname, phoneNum: phone, birthDay: mainView.birthTextField.text)
        APIManager.shared.signUp(data: data) { result in
            switch result {
            case .success( _):
                print("==회원가입 성공==")
                DispatchQueue.main.async {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            case .failure(let error):
                if let error = error as? SignUPError {
                    switch error {
                    case .requiredValueMissing:
                        print("\(error.errorDescription)")
                    case .existingUser:
                        print("\(error.errorDescription)")
                    }
                }
            }
        }
    }
    
    
}

extension BirthVC: AddTargetProtocol {
    func addTargets() {
        mainView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc private func nextButtonTapped() {
        let birth = mainView.birthTextField.text ?? ""
        let userInfo: String = "ID : \(email)\n닉네임 : \(nickname)\nTEL : \(phone)\n생일 : \(birth)"
        
        showAlert2Button(title: "가입하시겠습니까?", message: userInfo) { [weak self] _ in
            self?.signUp()
            NotificationCenter.default.post(name: Notification.Name.welcome, object: nil)
        }
    }
}
