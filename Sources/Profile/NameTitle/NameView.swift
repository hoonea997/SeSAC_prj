//
//  NameView.swift
//  Media
//
//  Created by hoon on 2023/08/29.
//

import UIKit


class NameView: BaseView {
    
    let textField = {
        let view = UITextField()
        view.placeholder = "이름"
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 10
        return view
    }()
    
    
    
    override func configureView() {
        addSubview(textField)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
    }
}
