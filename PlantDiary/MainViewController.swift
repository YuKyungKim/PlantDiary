//
//  MainViewController.swift
//  PlantDiary
//
//  Created by 김유경 on 2021/10/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    var plants = BehaviorRelay(value: [Plant(name: "수채화 고무나무"), Plant(name: "여인초"), Plant(name: "고사리"), Plant(name: "팬지")])
    // @TODO: 더미 데이터 삭제
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    lazy var plantsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView.register(PlantsCollectionViewCell.self, forCellWithReuseIdentifier: PlantsCollectionViewCell.identifier)
        return collectionView
    }()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Plant Diary"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil) // @TODO: add 버튼 연결
        
        self.view.addSubview(self.searchBar)
        self.searchBar.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.view.addSubview(self.plantsCollectionView)
        self.plantsCollectionView.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(self.view)
            make.top.equalTo(self.searchBar.snp.bottom)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        self.rxBind()
    }
    
    func rxBind() {
        self.plantsCollectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
        
        self.plants.bind(to: self.plantsCollectionView.rx.items) { (collectionView, row, item) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlantsCollectionViewCell.identifier, for: IndexPath(row: row, section: 0)) as! PlantsCollectionViewCell
            cell.plant = item
            return cell
        }.disposed(by:disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 16 * 2) / 2.0 - 8.0
        return CGSize(width: size, height: size)
    }
}
