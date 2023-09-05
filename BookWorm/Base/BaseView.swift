//
//  BaseView.swift
//  BookWorm
//
//  Created by hoon on 2023/09/05.
//

import UIKit

class BaseView: UIView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() { }
    
    func setConstraints() { }
    
}
