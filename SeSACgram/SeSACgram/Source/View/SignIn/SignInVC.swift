//
//  SignInVC.swift
//  SeSACgram
//
//  Created by hoon on 11/14/23.
//

import UIKit
import RxSwift
import RxCocoa
import Toast

final class SignInVC: BaseVC {
    
    private let disposeBag = DisposeBag()
    private let mainView = SignInView()
    
    //토스트메세지 스타일
    private let style = ToastStyle()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        addTargets()
        setNotificatioin()
    }
    
    deinit {
        print("====\(Self.self)====Deinit")
    }
    
    private func setNotificatioin() {
        NotificationCenter.default.addObserver(self, selector: #selector(showWelcomeToastMessage), name: Notification.Name.welcome, object: nil)
    }
    
    private func indicatorEffect() {
        mainView.signInButton.titleLabel?.isHidden = true
        mainView.indicator.isHidden = false
        mainView.indicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            //self.mainView.signInButton.titleLabel?.isHidden = false
            self.mainView.indicator.isHidden = true
            self.mainView.indicator.stopAnimating()
        }
    }
    
    @objc private func showWelcomeToastMessage() {
        self.view.makeToast("회원가입을 축하드립니다\n로그인을 진행해주세요", duration: 2.0, position: .center, title: nil, image: nil, style: style, completion: nil)
    }
    
    //    @objc private func showByeToastMessage() {
    //        print("ByeMessage실행됨")
    //        self.view.makeToast("탈퇴가 완료되었습니다.\n다음에도 찾아주세요!", duration: 2.0, position: .center, title: nil, image: nil, style: style, completion: nil)
    //    }
    
}

extension SignInVC: AddTargetProtocol {
    func addTargets() {
        mainView.signInButton.addTarget(self,
                                        action: #selector(signInButtonTapped),
                                        for: .touchUpInside)
        mainView.signUpButton.addTarget(self,
                                        action: #selector(signUPButtonTapped),
                                        for: .touchUpInside)
    }
    
    @objc private func signInButtonTapped() {
        let email = mainView.emailTextField.text ?? ""
        let pw = mainView.pwTextField.text ?? ""
        let data = LogIn(email: email, password: pw)
        APIManager.shared.login(data: data) { result in
            switch result {
            case .success(let value):
                print("==로그인 성공==")
                self.indicatorEffect()
                UserDefaultsHelper.shared.isLogIn = true
                UserDefaultsHelper.shared.accessToken = value.token
                UserDefaultsHelper.shared.refreshToken = value.refreshToken
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.view?.window?.rootViewController = TabBarVC()
                    self.view.window?.makeKeyAndVisible()
                }
            case .failure(let failure):
                if let error = failure as? LogInError {
                    switch error {
                    case .requiredValueMissing:
                        self.showAlert1Button(title: "필수값을 채워주세요")
                    case .unsubscribe:
                        self.showAlert1Button(title: "미가입 또는 비밀번호 불일치입니다.")
                    }
                }
            }
        }
    }
    
    
    @objc private func signUPButtonTapped() {
        let vc = EmailVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
