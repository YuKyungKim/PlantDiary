//
//  PlantsCollectionViewCell.swift
//  PlantDiary
//
//  Created by 김유경 on 2021/10/25.
//

import Foundation
import UIKit
import SnapKit

class PlantsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PlantsCollectionViewCell"
    
    var thumImageView = UIImageView()
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    var plant: Plant? {
        didSet {
            bind(plant: plant)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.thumImageView.image = UIImage(named: "image_plant_default")
        
        self.configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    private func configure() {
        
        contentView.addSubview(thumImageView)
        contentView.addSubview(nameLabel)
        
        thumImageView.snp.makeConstraints { (make) in
            make.width.centerX.top.equalTo(contentView)
            make.bottom.equalTo(nameLabel.snp.top)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.bottom.width.centerX.equalTo(contentView)
        }
    }
    
    private func bind(plant: Plant?) {
        if let plant = plant {
            self.nameLabel.text = plant.name
            
            if let imageUrl = plant.imageUrl {
                // @TODO: image set
            }
        }
        
    }
}
