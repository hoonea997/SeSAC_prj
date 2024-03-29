//
//  PostView.swift
//  SeSACgram
//
//  Created by hoon on 11/30/23.
//

import UIKit
import SnapKit
import Then

final class PostView: BaseView {
    let size = UIScreen.main.bounds.width / 4
    
    lazy var imagePickerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.backgroundColor = .clear
        $0.register(ImagePickerCell.self, forCellWithReuseIdentifier: ImagePickerCell().description)
        $0.register(AddedImageCell.self, forCellWithReuseIdentifier: AddedImageCell().description)
        $0.showsHorizontalScrollIndicator = false
    }
    
    let title = UILabel().then {
        $0.text = "제목"
        $0.font = Constants.Font.PostContentTitle
    }
    let titleTextField = CustomTextField(placeholder: "제목", style: .id)
    
    let contentTitle = UILabel().then {
        $0.text = "자세한 설명"
        $0.font = Constants.Font.PostContentTitle
    }
    let contentTextView = CustomTextView()
    
    
    let postButton = UIButton.responsiveButton(title: "게시하기", color: Constants.Color.DeepGreen, isEnable: false)
    
    override func configureView() {
        addSubview(imagePickerCollectionView)
        addSubview(postButton)
        addSubview(title)
        addSubview(titleTextField)
        addSubview(contentTitle)
        addSubview(contentTextView)
    }
    
    override func setConstraints() {
        imagePickerCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(self.size + 32)
        }
        postButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(Constants.Frame.buttonHeight)
            $0.bottom.equalTo(self.safeAreaInsets).inset(75)
        }
        title.snp.makeConstraints {
            $0.top.equalTo(imagePickerCollectionView.snp.bottom).offset(30)
            $0.leading.equalTo(21)
        }
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(Constants.Frame.textFieldHeight)
        }
        contentTitle.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(40)
            $0.leading.equalTo(21)
        }
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(contentTitle.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(titleTextField.snp.height).multipliedBy(3)
        }
    }
    
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: size, height: size)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 24, bottom: 12, right: 0)
        return layout
    }
}
