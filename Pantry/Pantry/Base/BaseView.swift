//
//  BaseView.swift
//  Pantry
//
//  Created by hoon on 2023/09/25.
//

import UIKit

class BaseView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.natural
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configureView() { }
    
    func setConstraints() { }
    
    //itemCell layout
    func allCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .vertical
        let size = UIScreen.main.bounds.width - 36
        layout.itemSize = CGSize(width: size / 2, height: (size / 2) * 0.52)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 12, bottom: 12, right: 12)
        return layout
    }
    
}
