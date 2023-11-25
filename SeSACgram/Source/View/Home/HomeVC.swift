//
//  HomeVC.swift
//  SeSACgram
//
//  Created by hoon on 11/14/23.
//

import UIKit

final class HomeVC: BaseVC {
    
    let mainView = HomeView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("====\(Self.self)====Deinit")
    }
    
}
