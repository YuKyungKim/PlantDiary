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
import RealmSwift

class MainViewController: UIViewController {
    var plants = BehaviorRelay<[Plant]>(value: [])
    
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
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // @TODO: 더미 데이터 삭제
//        let plant1 = Plant(name: "수채화 고무나무")
//        plant1.lastWaterAt = Date(timeIntervalSinceNow: -7 * 60 * 60 * 24)
//        plant1.lastFertilizerAt = Date(timeIntervalSinceNow: -4 * 60 * 60 * 24)
//        plant1.birthAt = Date(timeIntervalSinceNow: -180 * 60 * 60 * 24)
//        let plant2 = Plant(name: "여인초")
//        plant2.lastWaterAt = Date(timeIntervalSinceNow: -3 * 60 * 60 * 24)
//        plant2.birthAt = Date(timeIntervalSinceNow: -7 * 60 * 60 * 24)
//        let plant3 = Plant(name: "팬지")
//        plant3.lastWaterAt = Date(timeIntervalSinceNow: -2 * 60 * 60 * 24)
//        plant3.lastFertilizerAt = Date(timeIntervalSinceNow: -14 * 60 * 60 * 24)
//        let plant4 = Plant(name: "금어초")
//        plant4.lastWaterAt = Date(timeIntervalSinceNow: -1 * 60 * 60 * 24)
        
//        plants.accept([plant1, plant2, plant3, plant4])

        self.navigationItem.title = "Plant Diary"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onClickAdd))
        
        self.setView()
        
        self.rxBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let realm = try! Realm()
        let savedPlants = Array(realm.objects(Plant.self))
        self.plants.accept(savedPlants)
    }
    
    func setView() {
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
    }
    
    func rxBind() {
        self.plantsCollectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
        
        self.plants.bind(to: self.plantsCollectionView.rx.items) { (collectionView, row, item) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlantsCollectionViewCell.identifier, for: IndexPath(row: row, section: 0)) as! PlantsCollectionViewCell
            let cellViewModel = PlantsCollectionViewModel(item)
            cellViewModel.configure(cell)
            return cell
        }.disposed(by:disposeBag)
    }
    
    @objc func onClickAdd() {
        let plantAddVC = PlantAddViewController()
        self.navigationController?.pushViewController(plantAddVC, animated: true)
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
