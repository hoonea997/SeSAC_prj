//
//  LogInStateManager.swift
//  SeSACgram
//
//  Created by hoon on 11/26/23.
//

import UIKit

final class LogInStateManager {
    static let shared = LogInStateManager()
    private init () { }
    
    private var isLogged = UserDefaultsHelper.shared.isLogIn //default: false
    private var isValidToken: Bool = false
    
    
    private func checkToken(completion: @escaping () -> Void) {
        APIManager.shared.updateToken { [weak self] result in
            switch result {
            case .success:
                self?.isValidToken = true
            case .failure(let error):
                if let error = error as? TokenError {
                    switch error {
                    case .validToken:
                        self?.isValidToken = true
                    default:
                        self?.isValidToken = false
                    }
                }
            }
            completion()
        }
    }
    

    
    func rootViewControl(completion: @escaping (Bool) -> Void) {
        print("로그인 여부", isLogged)
        checkToken {
            if self.isLogged && self.isValidToken {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
