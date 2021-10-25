//
//  MainViewController.swift
//  PlantDiary
//
//  Created by 김유경 on 2021/10/25.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PlantsCollectionViewCell.self, forCellWithReuseIdentifier: PlantsCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Plant Diary"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil) // @TODO: add 버튼 연결
        
        self.view.addSubview(self.searchBar)
        self.searchBar.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.centerX.equalTo(self.view)
        }
        
        self.view.addSubview(self.plantsCollectionView)
        self.plantsCollectionView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.top.equalTo(self.searchBar.snp.bottom)
            make.bottom.equalTo(self.view.snp.bottom)
            make.centerX.equalTo(self.view)
        }
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

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlantsCollectionViewCell.identifier, for: indexPath) as! PlantsCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 16 * 2) / 2.0 - 8.0
        return CGSize(width: size, height: size)
    }
    
}
