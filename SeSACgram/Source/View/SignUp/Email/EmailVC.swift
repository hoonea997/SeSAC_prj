//
//  EmailVC.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import Foundation

final class EmailVC: BaseVC {
    
    private let mainView = EmailView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        addTargets()
    }
    
}

extension EmailVC: AddTargetProtocol {
    func addTargets() {
        mainView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc private func nextButtonTapped() {
        let vc = PWVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
