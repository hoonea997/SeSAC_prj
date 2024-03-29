//
//  AllPageViewController.swift
//  Pantry
//
//  Created by hoon on 2023/10/09.
//

import UIKit
import BarcodeScanner
import Toast
import RealmSwift

class AllPageViewController: BaseVC {
    
    var rfID: ObjectId?
    var selectedSort: Sort = .Added
    let mainView = AllPageView()
    let repository = RefrigeratorRepository()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.switchDelegate = self
        mainView.delegate = self
        
        mainView.itemList = repository.fetch(selectedSort, rfObjectid: rfID!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name("itemReload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(added), name: Notification.Name("All_Added"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ExpFastest), name: Notification.Name("All_ExpFastest"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ExpSlowest), name: Notification.Name("All_ExpSlowest"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ExpiredGoods), name: Notification.Name("All_ExpiredGoods"), object: nil)
    }
    
    
    override func configureView() {
        mainView.filterButton.addTarget(self,
                                        action: #selector(filterButtonTapped),
                                        for: .touchUpInside)
    }
    
    override func setConstraints() {
        
    }
    
    @objc private func reloadData() {
        mainView.allCollectionView.reloadData()
    }
    
    
    
    @objc private func filterButtonTapped() {
        let bulletinBoardVC = FilterButtonVC.instance()
        bulletinBoardVC.delegate = self
        bulletinBoardVC.pageOption = .All
        bulletinBoardVC.selectedSort = self.selectedSort
        addDim()
        present(bulletinBoardVC, animated: true)
    }
    
    private func addDim() {
        view.addSubview(mainView.bgView)
        mainView.bgView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.mainView.bgView.alpha = 0.5
        }
    }
    
    private func removeDim() {
        DispatchQueue.main.async { [weak self] in
            self?.mainView.bgView.removeFromSuperview()
        }
    }
    
    
}

extension AllPageViewController: BulletinDelegate {
    func onTapClose() {
        self.removeDim()
    }
}

extension AllPageViewController: SwitchScreenProtocol, NavPushProtocol {
    func pushView(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func switchScreen(nav: UINavigationController) {
        present(nav, animated: true)
    }
}


extension AllPageViewController {
    //추가된 순
    @objc private func added() {
        selectedSort = .Added
        mainView.filterLabel.text = NSLocalizedString("SortNetAdded", comment: "")
        mainView.itemList = repository.fetch(selectedSort, rfObjectid: rfID!)
    }
    @objc private func ExpFastest() {
        selectedSort = .ExpFastest
        mainView.filterLabel.text = NSLocalizedString("SortFastestDate", comment: "")
        mainView.itemList = repository.fetch(selectedSort, rfObjectid: rfID!)
    }
    @objc private func ExpSlowest() {
        selectedSort = .ExpSlowest
        mainView.filterLabel.text = NSLocalizedString("SortSlowestDate", comment: "")
        mainView.itemList = repository.fetch(selectedSort, rfObjectid: rfID!)
    }
    @objc private func ExpiredGoods() {
        selectedSort = .ExpiredGoods
        mainView.filterLabel.text = NSLocalizedString("ExpiredGoods", comment: "")
        mainView.itemList = repository.fetch(selectedSort, rfObjectid: rfID!)
    }
}
