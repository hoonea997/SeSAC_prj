//
//  RefigerPageView.swift
//  Pantry
//
//  Created by hoon on 2023/10/09.
//

import UIKit
import Then
import SnapKit

class RefigerPageView: BaseView {
    
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))

    lazy var allCollectionView = UICollectionView(frame: .zero, collectionViewLayout: allCollectionViewLayout()).then {
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.register(ItemsCell.self, forCellWithReuseIdentifier: ItemsCell.identifier)
    }
    
    let filterButton = UIButton.makeHighlightedButton(withImageName: "slider.horizontal.3", size: 34).then {
        $0.tintColor = .black
    }
    
    let introDuctionButton = UIButton.makeHighlightedButton(withImageName: "exclamationmark.circle", size: 28)
    
    override func configureView() {
        super.configureView()
        addSubview(blurEffect)
        addSubview(filterButton)
        addSubview(allCollectionView)
        addSubview(introDuctionButton)
    }
    
    
    override func setConstraints() {
        blurEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        filterButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(4)
            $0.leading.equalTo(self.snp.leading).inset(18)
        }
        
        allCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterButton.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        introDuctionButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.trailing.equalTo(self.snp.trailing).inset(18)
        }
    }
    
}

extension RefigerPageView {
    private func allCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .vertical
        let size = UIScreen.main.bounds.width - 36
        layout.itemSize = CGSize(width: size / 2, height: (size / 2) * 0.7)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 12, bottom: 12, right: 12)
        return layout
    }
}

extension RefigerPageView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemsCell.identifier, for: indexPath) as! ItemsCell
        
        return cell
    }
}
